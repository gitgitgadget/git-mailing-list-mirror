From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: git fetch origin hanging in 1.7.0
Date: Tue, 16 Feb 2010 15:18:21 +0800
Message-ID: <20100216151821.994ace31.rctay89@gmail.com>
References: <7e3605161002151608t44bd320cgcd589796a9ec902b@mail.gmail.com>
	<20100216063959.GC2169@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Kevin Menard <nirvdrum@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 16 08:18:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhHhg-0007bb-UW
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 08:18:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932596Ab0BPHSf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 02:18:35 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:57094 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754473Ab0BPHSe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 02:18:34 -0500
Received: by ywh6 with SMTP id 6so4265970ywh.4
        for <git@vger.kernel.org>; Mon, 15 Feb 2010 23:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=EzsCMOOZyIU2VaRpkQLWLoiTHOwyCVmYwOMXmCq86NQ=;
        b=oSD8QKUT95Mi8+HBbrrpggdiug3wA5jmDv6IzG6a984aFMHAqg4joGbvRPPOaPz2IQ
         t2z7I141XGojpuzIa2m2dWPyoxpwwRcohKi4Y5Y3jlq0JD9cOdaXA0vZbEq3jxB+hcAQ
         /zF4FO7TUPCamT6fnC2mfo7trVogt70dN3mBg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=hvlfH6LOhG00Cwi+gPk3cL49XX9ws07U+S4ehgMIu58/w+4QSBsk1JgKE/3mdmbk6D
         CMnIA05BQF5QQ3ZCs5mGW4h9ONDwhQN5phPsVaKf/O9yx2DYdk7knObMtuSpy3OgWIj7
         /71XaRSkyvOkR86iNlivwyV55X3gsg75JKdP8=
Received: by 10.91.53.11 with SMTP id f11mr2456242agk.100.1266304711426;
        Mon, 15 Feb 2010 23:18:31 -0800 (PST)
Received: from your-cukc5e3z5n (cm91.zeta153.maxonline.com.sg [116.87.153.91])
        by mx.google.com with ESMTPS id 13sm5045654gxk.13.2010.02.15.23.18.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 15 Feb 2010 23:18:30 -0800 (PST)
In-Reply-To: <20100216063959.GC2169@coredump.intra.peff.net>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140078>

Hi,

On Tue, 16 Feb 2010 01:39:59 -0500
Jeff King <peff@peff.net> wrote:
> I can reproduce the bug with:
> 
>   $ mkdir foo && (cd foo && git init)
>   $ git clone foo bar
>   Initialized empty Git repository in /home/peff/bar/.git/
>   warning: You appear to have cloned an empty repository.
>   $ cd bar && git fetch
> 
> which hangs on a pipe read(). It bisects to 61b075b (Support taking over
> transports, 2009-12-09) from Ilari (cc'd). It looks like we get the
> empty ref list once in get_remote_heads, and then try to get it again
> and hang.

I agree with the diagnosis. With gdb, I find that program execution
hangs on the packet_read_line() call in connect.c::get_remote_heads().

> diff --git a/transport.c b/transport.c
> index ad25b98..e6f9464 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -1010,7 +1010,8 @@ int transport_push(struct transport *transport,
>  
>  const struct ref *transport_get_remote_refs(struct transport *transport)
>  {
> -	if (!transport->remote_refs)
> +	struct git_transport_data *data = transport->data;
> +	if (!data->got_remote_heads)
>  		transport->remote_refs = transport->get_refs_list(transport, 0);
>  
>  	return transport->remote_refs;

NAK. This will only work if the given transport is git://. (My take
below.)

> That fixes the problem for me, but I am totally clueless about this
> code. Do all transports have a git_transport_data (if so, then why is it
> a void pointer?).

It is void so that it can be any struct - for example,
git_transport_data, bundle_transport_data. That way, transport->data
can point to any transport-specific data, while keeping the compiler
satisfied at compile-time.

-- >8 --
Subject: [PATCH] transport: add got_remote_refs flag

tranport.c::transport_get_remote_refs() used to check
transport->remote_refs to determine whether transport->get_refs_list()
should be invoked.

However, transport->remote_refs could evaluate to false (eg. if it is
NULL), causingo transport->get_refs_list() to be invoked unnecessarily.

Introduce a flag, transport->got_remote_refs, and make
tranport.c::transport_get_remote_refs() check this flag rather than
evaluating transport->remote_refs.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 transport.c |    5 ++++-
 transport.h |    6 ++++++
 2 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/transport.c b/transport.c
index 3846aac..08e4fa0 100644
--- a/transport.c
+++ b/transport.c
@@ -918,6 +918,7 @@ struct transport *transport_get(struct remote *remote, const char *url)
 	if (!remote)
 		die("No remote provided to transport_get()");
 
+	ret->got_remote_refs = 0;
 	ret->remote = remote;
 	helper = remote->foreign_vcs;
 
@@ -1079,8 +1080,10 @@ int transport_push(struct transport *transport,
 
 const struct ref *transport_get_remote_refs(struct transport *transport)
 {
-	if (!transport->remote_refs)
+	if (!transport->got_remote_refs) {
 		transport->remote_refs = transport->get_refs_list(transport, 0);
+		transport->got_remote_refs = 1;
+	}
 
 	return transport->remote_refs;
 }
diff --git a/transport.h b/transport.h
index 7cea5cc..1cca13b 100644
--- a/transport.h
+++ b/transport.h
@@ -20,6 +20,12 @@ struct transport {
 	const struct ref *remote_refs;
 
 	/**
+	 * Indicates whether the remote_refs member has been set. Set by
+	 * transport.c::transport_get_remote_refs().
+	 */
+	unsigned got_remote_refs : 1;
+
+	/**
 	 * Returns 0 if successful, positive if the option is not
 	 * recognized or is inapplicable, and negative if the option
 	 * is applicable but the value is invalid.
-- 
1.7.0.1.gcd472.dirty

-- 
Cheers,
Ray Chuan
