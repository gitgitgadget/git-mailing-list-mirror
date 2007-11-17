From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Rewrite some function exit paths to avoid "unreachable
	code" traps
Date: Sat, 17 Nov 2007 10:46:17 +0100
Message-ID: <20071117094617.GD4086@steel.home>
References: <Pine.LNX.4.64.0711152317140.7416@bianca.dialin.t-online.de> <20071115230002.GA24069@steel.home> <7v1war3xrq.fsf@gitster.siamese.dyndns.org> <20071116074850.GA3400@steel.home> <Pine.LNX.4.64.0711162346270.7281@bianca.dialin.t-online.de>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Guido Ostkamp <git@ostkamp.fastmail.fm>
X-From: git-owner@vger.kernel.org Sat Nov 17 10:46:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItKG7-00074X-UH
	for gcvg-git-2@gmane.org; Sat, 17 Nov 2007 10:46:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752340AbXKQJqW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2007 04:46:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752196AbXKQJqW
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Nov 2007 04:46:22 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:13144 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750963AbXKQJqV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2007 04:46:21 -0500
Received: from tigra.home (Fcbd3.f.strato-dslnet.de [195.4.203.211])
	by post.webmailer.de (mrclete mo1) (RZmta 14.0)
	with ESMTP id e02664jAH2b8Qm ; Sat, 17 Nov 2007 10:46:18 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 950F7277AE;
	Sat, 17 Nov 2007 10:46:18 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 1149056D22; Sat, 17 Nov 2007 10:46:18 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711162346270.7281@bianca.dialin.t-online.de>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaHqBg+Ffo=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65265>

Noticed by Guido Ostkamp for Sun's Workshop cc.

Originally-by: Guido Ostkamp <git@ostkamp.fastmail.fm>
Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
Guido Ostkamp, Fri, Nov 16, 2007 23:52:01 +0100:
>
> What about the xdiff/xdiffi.c problem that should also be solved?
>

Here you go.

 builtin-apply.c |    5 +++--
 utf8.c          |    2 +-
 xdiff/xdiffi.c  |   14 +++++++-------
 xdiff/xutils.c  |    5 ++---
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 8edcc08..6267396 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -668,13 +668,13 @@ static char *git_header_name(char *line, int llen)
 		default:
 			continue;
 		case '\n':
-			return NULL;
+			goto eol;
 		case '\t': case ' ':
 			second = name+len;
 			for (;;) {
 				char c = *second++;
 				if (c == '\n')
-					return NULL;
+					goto eol;
 				if (c == '/')
 					break;
 			}
@@ -683,6 +683,7 @@ static char *git_header_name(char *line, int llen)
 			}
 		}
 	}
+eol:
 	return NULL;
 }
 
diff --git a/utf8.c b/utf8.c
index 8095a71..50c46af 100644
--- a/utf8.c
+++ b/utf8.c
@@ -262,7 +262,7 @@ int print_wrapped_text(const char *text, int indent, int indent2, int width)
 					print_spaces(indent);
 				fwrite(start, text - start, 1, stdout);
 				if (!c)
-					return w;
+					break;
 				else if (c == '\t')
 					w |= 0x07;
 				space = text;
diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 5cb7171..365d768 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -110,7 +110,7 @@ static long xdl_split(unsigned long const *ha1, long off1, long lim1,
 				spl->i1 = i1;
 				spl->i2 = i2;
 				spl->min_lo = spl->min_hi = 1;
-				return ec;
+				goto end;
 			}
 		}
 
@@ -145,7 +145,7 @@ static long xdl_split(unsigned long const *ha1, long off1, long lim1,
 				spl->i1 = i1;
 				spl->i2 = i2;
 				spl->min_lo = spl->min_hi = 1;
-				return ec;
+				goto end;
 			}
 		}
 
@@ -184,7 +184,7 @@ static long xdl_split(unsigned long const *ha1, long off1, long lim1,
 			if (best > 0) {
 				spl->min_lo = 1;
 				spl->min_hi = 0;
-				return ec;
+				goto end;
 			}
 
 			for (best = 0, d = bmax; d >= bmin; d -= 2) {
@@ -208,7 +208,7 @@ static long xdl_split(unsigned long const *ha1, long off1, long lim1,
 			if (best > 0) {
 				spl->min_lo = 0;
 				spl->min_hi = 1;
-				return ec;
+				goto end;
 			}
 		}
 
@@ -254,11 +254,11 @@ static long xdl_split(unsigned long const *ha1, long off1, long lim1,
 				spl->min_lo = 0;
 				spl->min_hi = 1;
 			}
-			return ec;
+			goto end;
 		}
 	}
-
-	return -1;
+end:
+	return ec;
 }
 
 
diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index 2ade97b..533ff76 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -230,10 +230,9 @@ int xdl_recmatch(const char *l1, long s1, const char *l2, long s2, long flags)
 			i2++;
 		}
 		return i1 >= s1 && i2 >= s2;
-	} else
-		return s1 == s2 && !memcmp(l1, l2, s1);
+	}
 
-	return 0;
+	return s1 == s2 && !memcmp(l1, l2, s1);
 }
 
 static unsigned long xdl_hash_record_with_whitespace(char const **data,
-- 
1.5.3.5.750.g9f37
