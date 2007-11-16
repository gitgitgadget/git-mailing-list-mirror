From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Fix Solaris compiler warnings
Date: Fri, 16 Nov 2007 08:48:50 +0100
Message-ID: <20071116074850.GA3400@steel.home>
References: <Pine.LNX.4.64.0711152317140.7416@bianca.dialin.t-online.de> <20071115230002.GA24069@steel.home> <7v1war3xrq.fsf@gitster.siamese.dyndns.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Guido Ostkamp <git@ostkamp.fastmail.fm>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 16 08:49:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Isvws-0007Su-8C
	for gcvg-git-2@gmane.org; Fri, 16 Nov 2007 08:49:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752084AbXKPHsx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2007 02:48:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752021AbXKPHsx
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Nov 2007 02:48:53 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:17670 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751918AbXKPHsw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2007 02:48:52 -0500
Received: from tigra.home (Fcbc7.f.strato-dslnet.de [195.4.203.199])
	by post.webmailer.de (mrclete mo21) (RZmta 14.0)
	with ESMTP id 6026a0jAG2xHWH ; Fri, 16 Nov 2007 08:48:51 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id C1A15277AE;
	Fri, 16 Nov 2007 08:48:50 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 3197A56D22; Fri, 16 Nov 2007 08:48:50 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7v1war3xrq.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaHqBsKmZA=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65201>

Junio C Hamano, Fri, Nov 16, 2007 00:16:25 +0100:
> Alex Riesen <raa.lkml@gmail.com> writes:
> 
> > Guido Ostkamp, Thu, Nov 15, 2007 23:19:11 +0100:
> >> Hello,
> >>
> >> the below patch fixes some compiler warnings returned by Solaris Workshop 
> >> Compilers.
> >>
> >>     CC builtin-apply.o
> >> "builtin-apply.c", line 686: warning: statement not reached
> >>     CC utf8.o
> >> "utf8.c", line 287: warning: statement not reached
> >>     CC xdiff/xdiffi.o
> >> "xdiff/xdiffi.c", line 261: warning: statement not reached
> >
> > All these are wrong. That's a fantastically broken piece of compiler
> 
> Eh?
> 
> I've looked at builtin-apply and utf8 cases but these returns
> are after an endless loop whose exit paths always return
> directly, so these return statements are in fact never reached.
> 
> Dumber compilers may not notice and if you remove these returns
> they may start complaining, though. 

Hmm... Guido, I owe you an appology. Still, consider this patch
instead (it does not fix the return in xdiff/xdiffi.c though):


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
