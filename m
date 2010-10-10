From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v3 11/14] daemon: report connection from root-process
Date: Sun, 10 Oct 2010 21:42:26 +0200
Message-ID: <AANLkTinEmrHMfw0z=uwOs9FDRcta3gwcEvc1MBi+_7C-@mail.gmail.com>
References: <1286716854-5744-1-git-send-email-kusmabite@gmail.com>
 <1286716854-5744-12-git-send-email-kusmabite@gmail.com> <201010102058.16773.j6t@kdbg.org>
 <AANLkTinz69u-hh-URqBrpdcrm+84N2BC7Ov4O8xeuW73@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Oct 10 21:42:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P51nK-0001Ld-BH
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 21:42:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379Ab0JJTms (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Oct 2010 15:42:48 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:39032 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750960Ab0JJTmr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Oct 2010 15:42:47 -0400
Received: by vws2 with SMTP id 2so554728vws.19
        for <git@vger.kernel.org>; Sun, 10 Oct 2010 12:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type;
        bh=jYJSAB7ZU7tMfJAmT/dKit8pP2IAirPXQJJhM18AKug=;
        b=aZ1x/e8EYhEYcJ7nPVwEecZ2i32w6RSLGPzttSjDNGnDnS5qfrpxzlBzX5sW89pqbY
         pk1AiFyWQOdChSVgOFrpwBcm5JdPPRl2Im2x9oql+gRVUFQcM93YleyJdPXTlPOGPt5/
         /hOAfd4LHmGzrmNxdu5Rkgr9dRAosY9eQvWJo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        b=QGo2m41xK1qh7Eo1YEUQtjhLzrJtK2R/OYcPNxVZwwtOwbeqMYqwhoD4CcWAUNXwvK
         yvpArZL0pwk+Rcv94Q7v4ELgHqBykwl6zbkxSS7lzXaMfR+aXdo91z9njIxinhZ2ftwA
         niAL3dCJ6tc5ZkKDPA1tMWBkdGn7ijkZmqbtQ=
Received: by 10.220.90.195 with SMTP id j3mr88472vcm.254.1286739767104; Sun,
 10 Oct 2010 12:42:47 -0700 (PDT)
Received: by 10.220.45.196 with HTTP; Sun, 10 Oct 2010 12:42:26 -0700 (PDT)
In-Reply-To: <AANLkTinz69u-hh-URqBrpdcrm+84N2BC7Ov4O8xeuW73@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158691>

On Sun, Oct 10, 2010 at 9:31 PM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
> On Sun, Oct 10, 2010 at 8:58 PM, Johannes Sixt <j6t@kdbg.org> wrote:
>> On Sonntag, 10. Oktober 2010, Erik Faye-Lund wrote:
>>> Report incoming connections from the process that
>>> accept() the connection instead of the handling
>>> process.
>>>
>>> This enables "Connection from"-reporting on
>>> Windows, where getpeername(0, ...) consistently
>>> fails.
>>
>> Is this from the process that you invoke with --serve? then this failure could
>> be due to Winsockets not being initilized. Did you check that?
>>
>
> I've tried that, and unfortunately it lack of socket initialization
> does not seem to be the reason :(
>

But looking at it a bit more, I can do the following code-reduction on
top, changing this to a +10 lines to a -2 lines patch ;)

diff --git a/daemon.c b/daemon.c
index 56a9bed..e9a4839 100644
--- a/daemon.c
+++ b/daemon.c
@@ -518,7 +518,7 @@ static void parse_host_arg(char *extra_args, int buflen)
 }


-static int execute(struct sockaddr *addr)
+static int execute()
 {
 	static char line[1000];
 	int pktlen, len, i;
@@ -1179,22 +1179,10 @@ int main(int argc, char **argv)
 		    base_path);

 	if (serve_mode) {
-		struct sockaddr_storage ss;
-		struct sockaddr *peer = (struct sockaddr *)&ss;
-		socklen_t slen = sizeof(ss);
-
 		if (inetd_mode && !freopen("/dev/null", "w", stderr))
 			die_errno("failed to redirect stderr to /dev/null");

-		if (!getpeername(0, peer, &slen)) {
-			int port = -1;
-			char *addrstr = get_addrstr(&port, peer);
-			setenv("REMOTE_ADDR", addrstr, 1);
-			loginfo("[%"PRIuMAX"] Connection from %s:%d",
-			    (uintmax_t)getpid(), addrstr, port);
-		}
-
-		return execute(peer);
+		return execute();
 	}

 #ifdef _POSIX_VERSION
