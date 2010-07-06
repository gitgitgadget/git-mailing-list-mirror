From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Bugfix: grep: Do not colorize output when -O is set
Date: Tue, 6 Jul 2010 14:38:45 -0500
Message-ID: <20100706193845.GA7438@burratino>
References: <1278064941-30689-1-git-send-email-ayiehere@gmail.com>
 <4C2E1185.1040406@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nazri Ramliy <ayiehere@gmail.com>, gitster@pobox.com,
	git@vger.kernel.org, johannes.schindelin@gmx.de
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Jul 06 21:39:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWDzT-0006Yv-BB
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 21:39:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754949Ab0GFTja convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Jul 2010 15:39:30 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:43337 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751491Ab0GFTj3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jul 2010 15:39:29 -0400
Received: by pxi14 with SMTP id 14so2323274pxi.19
        for <git@vger.kernel.org>; Tue, 06 Jul 2010 12:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=U24rUIoFF+sGZu637HcwtmfjKHYU/76zlQOE5xukYzw=;
        b=cEkBUgUbbYCT/pVyr3AXltX7M5aR+b5xHWoTwrDlr8ArMH4rCK8+k7Q9qJUt6mnLnp
         ILLeywTKPRY8IAn6eSruRqg+SBAVZpV0woc/QHIGttveybA/IAp0oQmstJihglok46X9
         CaCWR/B+kv33UX8wFS9LhN2h12GK62P7DFU+M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=V1W+xNu3jrx/7SiifSns0dxmPcVAdkT88rD9Hto0+rNUx03NIyMEydssK1gK2TVCz9
         Q/tb0yL5UFLgiurJf9Q3c/MUiDs3YIyfhcs0UBfvefCgPr0snWa7HUx3GRVDVhFehePl
         +vzu4WgjfmwAaPFt2umqQTSz+C9QXPIljIUCs=
Received: by 10.114.75.7 with SMTP id x7mr5859060waa.171.1278445168477;
        Tue, 06 Jul 2010 12:39:28 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 34sm24842294ibi.0.2010.07.06.12.39.26
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 06 Jul 2010 12:39:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4C2E1185.1040406@lsrfire.ath.cx>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150404>

Hi,

Ren=C3=A9 Scharfe wrote:

> Hmm, but with --open-files-in-pager without argument or -Oless colour=
s
> may be handled correctly and desirable.

Sorry I missed this before.  Is there really a pager that will accept
\e[36m as a command-line argument and do something reasonable with it?

> Turning colouring off with -O
> is probably the most sensible default, but is it possible to allow
> turning it back on explicitly (--color -O)?

A person trying that might be wanting to highlight matches in the
pager rather than in argv itself. :)  Unfortunately, it is not
completely obvious how to comply.

=E2=80=98less=E2=80=99 already highlights matches by default, though no=
t in the color
configured for git.  grep -O will tell =E2=80=98less=E2=80=99 what to l=
ook for if
there was just one pattern.

editors like vim tend to use syntax highlighting in addition to
optionally highlighting search matches.

Probably a better solution is to recommend -C option, possibly
implementing -C infinity so people don=E2=80=99t have to use -C 1000000=
=2E

But your point is well taken that the current behavior is confusing.
How about the following?

diff --git a/builtin/grep.c b/builtin/grep.c
index 7a9427d..921f554 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -835,6 +835,7 @@ int cmd_grep(int argc, const char **argv, const cha=
r *prefix)
 	struct string_list path_list =3D { NULL, 0, 0, 0 };
 	int i;
 	int dummy;
+	int use_color =3D -1;
 	int nongit =3D 0, use_index =3D 1;
 	struct option options[] =3D {
 		OPT_BOOLEAN(0, "cached", &cached,
@@ -881,7 +882,7 @@ int cmd_grep(int argc, const char **argv, const cha=
r *prefix)
 			"print NUL after filenames"),
 		OPT_BOOLEAN('c', "count", &opt.count,
 			"show the number of matches instead of matching lines"),
-		OPT__COLOR(&opt.color, "highlight matches"),
+		OPT__COLOR(&use_color, "highlight matches"),
 		OPT_GROUP(""),
 		OPT_CALLBACK('C', NULL, &opt, "n",
 			"show <n> context lines before and after matches",
@@ -994,6 +995,9 @@ int cmd_grep(int argc, const char **argv, const cha=
r *prefix)
 		argc--;
 	}
=20
+	if (use_color !=3D -1)
+		opt.color =3D use_color;
+
 	if (show_in_pager =3D=3D default_pager)
 		show_in_pager =3D git_pager(1);
 	if (show_in_pager) {
@@ -1006,6 +1010,8 @@ int cmd_grep(int argc, const char **argv, const c=
har *prefix)
 		use_threads =3D 0;
 	}
=20
+	if (show_in_pager && use_color)
+		die("cannot mix -O and --color");
 	if (!opt.pattern_list)
 		die("no pattern given.");
 	if (!opt.fixed && opt.ignore_case)
