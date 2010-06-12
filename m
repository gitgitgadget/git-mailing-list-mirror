From: Jeff King <peff@peff.net>
Subject: Re: Git sideband hook output
Date: Sat, 12 Jun 2010 00:07:17 -0400
Message-ID: <20100612040717.GA9419@coredump.intra.peff.net>
References: <20100608214632.GN14847@spearce.org>
 <A612847CFE53224C91B23E3A5B48BAC744839BF3DD@xmail3.se.axis.com>
 <alpine.LFD.2.00.1006090934320.30664@xanadu.home>
 <A612847CFE53224C91B23E3A5B48BAC744839BF6AE@xmail3.se.axis.com>
 <20100610183019.GR14847@spearce.org>
 <AANLkTikQQh4sUA7h2k1jvQ7aMgYyq7WFetJvJZvqpVxt@mail.gmail.com>
 <AANLkTikYBB1DsGRRsu4pSNr1j8fFXD-99c4lRAaBqd3M@mail.gmail.com>
 <3B9F4351-4608-455E-B433-A5337A946F8A@wincent.com>
 <AANLkTimPI-A_4H-vYtHIyfbSLERDo0vu-kbB3Qu3ZT06@mail.gmail.com>
 <7v631pgm9d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: kusmabite@gmail.com, Wincent Colaiuta <win@wincent.com>,
	PJ Hyett <pjhyett@gmail.com>, Scott Chacon <schacon@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 12 06:12:36 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONI5A-00014u-Mf
	for gcvg-git-2@lo.gmane.org; Sat, 12 Jun 2010 06:12:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773Ab0FLEHW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jun 2010 00:07:22 -0400
Received: from peff.net ([208.65.91.99]:43507 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750703Ab0FLEHV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jun 2010 00:07:21 -0400
Received: (qmail 16466 invoked by uid 107); 12 Jun 2010 04:07:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 12 Jun 2010 00:07:32 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 12 Jun 2010 00:07:17 -0400
Content-Disposition: inline
In-Reply-To: <7v631pgm9d.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148985>

On Fri, Jun 11, 2010 at 04:52:46PM -0700, Junio C Hamano wrote:

> Erik Faye-Lund <kusmabite@googlemail.com> writes:
> 
> >> Funny, as '>>' is basically meaningless. At least 'remote:' has semantic value (ie. it indicates _where_ something is coming from).
> >
> > How about '> ', which often means "quote" (e.g in e-mails)? Would that
> > be appropriate?
> 
> Not much better, IMNSHO.  Where do people get the idea that line-noises
> are more descriptive than "remote:"?

I also find '>' ugly, but maybe it is worth quelling the bikeshed
discussion with something like the following.

diff --git a/cache.h b/cache.h
index 5e55367..c616513 100644
--- a/cache.h
+++ b/cache.h
@@ -999,6 +999,7 @@ extern int pager_use_color;
 
 extern const char *editor_program;
 extern const char *excludes_file;
+extern const char *sideband_prefix;
 
 /* base85 */
 int decode_85(char *dst, const char *line, int linelen);
diff --git a/config.c b/config.c
index 9b6b1df..22a1b04 100644
--- a/config.c
+++ b/config.c
@@ -579,6 +579,9 @@ static int git_default_core_config(const char *var, const char *value)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.sidebandprefix"))
+		return git_config_string(&sideband_prefix, var, value);
+
 	/* Add other config variables here and to Documentation/config.txt. */
 	return 0;
 }
diff --git a/sideband.c b/sideband.c
index d5ffa1c..be4a785 100644
--- a/sideband.c
+++ b/sideband.c
@@ -12,22 +12,27 @@
  * the remote died unexpectedly.  A flush() concludes the stream.
  */
 
-#define PREFIX "remote:"
+#define DEFAULT_PREFIX "remote:"
 
 #define ANSI_SUFFIX "\033[K"
 #define DUMB_SUFFIX "        "
 
 #define FIX_SIZE 10  /* large enough for any of the above */
 
+char *sideband_prefix = DEFAULT_PREFIX;
+
 int recv_sideband(const char *me, int in_stream, int out)
 {
-	unsigned pf = strlen(PREFIX);
+	unsigned pf = strlen(sideband_prefix);
 	unsigned sf;
 	char buf[LARGE_PACKET_MAX + 2*FIX_SIZE];
 	char *suffix, *term;
 	int skip_pf = 0;
 
-	memcpy(buf, PREFIX, pf);
+	if (pf > FIX_SIZE)
+		pf = FIX_SIZE;
+
+	memcpy(buf, sideband_prefix, pf);
 	term = getenv("TERM");
 	if (term && strcmp(term, "dumb"))
 		suffix = ANSI_SUFFIX;
