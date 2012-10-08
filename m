From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: upload-pack is slow with lots of refs
Date: Mon, 08 Oct 2012 17:05:53 +0200
Message-ID: <5072EBD1.40500@kdbg.org>
References: <CACBZZX70NTic2WtrXooTg+yBbiFFDAEX_Y-b=W=rAkcYKJ3T2g@mail.gmail.com> <20121003180324.GB27446@sigill.intra.peff.net> <7vobkj4cb4.fsf@alter.siamese.dyndns.org> <20121003185542.GA3635@sigill.intra.peff.net> <CAJo=hJtZ_8H6+kXPpZcRCbJi3LPuuF7M1U8YsjAp-iWvut9oMw@mail.gmail.com> <506E7D01.8080509@viscovery.net> <CAJo=hJsYVdWeG0ZyqexEXNfOq_k1XDR_gGP+fy_z==LvdnWJTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Oct 08 17:06:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLEuJ-0005pk-6V
	for gcvg-git-2@plane.gmane.org; Mon, 08 Oct 2012 17:06:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753532Ab2JHPGA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2012 11:06:00 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:44019 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752079Ab2JHPF7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2012 11:05:59 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id EED5F10012;
	Mon,  8 Oct 2012 17:05:54 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 137AF19F3EC;
	Mon,  8 Oct 2012 17:05:53 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120825 Thunderbird/15.0
In-Reply-To: <CAJo=hJsYVdWeG0ZyqexEXNfOq_k1XDR_gGP+fy_z==LvdnWJTQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207231>

Am 05.10.2012 18:57, schrieb Shawn Pearce:
> On Thu, Oct 4, 2012 at 11:24 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>> Upload-pack can just start
>> advertising refs in the "v1" way and announce a "v2" capability and listen
>> for response in parallel. A v2 capable client can start sending "wants" or
>> some other signal as soon as it sees the "v2" capability. Upload-pack,
>> which was listening for responses in parallel, can interrupt its
>> advertisements and continue with v2 protocol from here.
>>
>> This sounds so simple (not the implementation, of course) - I must be
>> missing something.
> 
> Smart HTTP is not bidirectional. The client can't cut off the server.

Smart HTTP does not need it: you already posted a better solution (I'm
refering to "&v=2").

> Its also more complex to code the server to listen for a stop command
> from the client at the same time the server is blasting out useless
> references to the client.

At least the server side does not seem to be that complex. See below.
Of course, the server blasted out some refs, but I'm confident that in
practice the client will be able to signal v2 capability after a few packets
of advertisements. You can switch on TCP_NODELAY for the first line with
the capabilities to ensure it goes out on the wire ASAP.

diff --git a/upload-pack.c b/upload-pack.c
index 2e90ccb..c29ae04 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -720,11 +720,20 @@ static void receive_needs(void)
 	free(shallows.objects);
 }
 
+static int client_spoke(void)
+{
+	struct pollfd pfd;
+	pfd.fd = 0;
+	pfd.events = POLLIN;
+	return poll(&pfd, 1, 0) > 0 &&
+		(pfd.revents & (POLLIN|POLLHUP));
+}
+
 static int send_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
 {
 	static const char *capabilities = "multi_ack thin-pack side-band"
 		" side-band-64k ofs-delta shallow no-progress"
-		" include-tag multi_ack_detailed";
+		" include-tag multi_ack_detailed version2";
 	struct object *o = lookup_unknown_object(sha1);
 	const char *refname_nons = strip_namespace(refname);
 
@@ -752,7 +761,8 @@ static int send_ref(const char *refname, const unsigned char *sha1, int flag, vo
 		if (o)
 			packet_write(1, "%s %s^{}\n", sha1_to_hex(o->sha1), refname_nons);
 	}
-	return 0;
+
+	return client_spoke();
 }
 
 static int mark_our_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
@@ -771,8 +781,14 @@ static void upload_pack(void)
 {
 	if (advertise_refs || !stateless_rpc) {
 		reset_timeout();
-		head_ref_namespaced(send_ref, NULL);
-		for_each_namespaced_ref(send_ref, NULL);
+		if (head_ref_namespaced(send_ref, NULL) ||
+		    for_each_namespaced_ref(send_ref, NULL)) {
+			/*
+			 * TODO: continue with protocol version 2
+			 * optimization: do not send refs
+			 * that were already sent
+			 */
+		}
 		packet_flush(1);
 	} else {
 		head_ref_namespaced(mark_our_ref, NULL);
