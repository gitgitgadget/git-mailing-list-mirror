From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH v2] dir.c: Avoid c99 array initialization
Date: Thu, 28 Aug 2008 17:47:22 -0500
Message-ID: <DvgiWt6vf5dOJWwhJg6Uvvb1c1lr9AZ9KS6iObwhTbjxnzKL45PkCw@cipher.nrlssc.navy.mil>
References: <7vwsi0dh61.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Alex Riesen <raa.lkml@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	=?ISO-8859-1?Q?David_K=E5gedal?= <davidk@lysator.liu.se>,
	Andreas Ericsson <ae@op5.se>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 29 00:48:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYqIG-0000YA-VL
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 00:48:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753252AbYH1Wrk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 18:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754291AbYH1Wrj
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 18:47:39 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:41094 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751528AbYH1Wrj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 18:47:39 -0400
Received: by mail.nrlssc.navy.mil id m7SMlNCC008611; Thu, 28 Aug 2008 17:47:23 -0500
In-Reply-To: <7vwsi0dh61.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 28 Aug 2008 22:47:22.0969 (UTC) FILETIME=[09065490:01C90960]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94195>

The following syntax:

        char foo[] = {
                [0] = 1,
                [7] = 2,
                [15] = 3
        };

is a c99 construct which some compilers do not support even though they
support other c99 constructs. This construct can be avoided by folding
these 'special' test cases into the sane_ctype array and making use of
the related infrastructure.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---


Junio C Hamano wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:

>> > I am reminded of a year old thread with my patch to this:
>> >
>> >   http://kerneltrap.org/mailarchive/git/2007/4/15/243541
>> >
>> > The patch never applied.  I wonder why.  Was it just Dscho's comment?
> 
> I think it was an unanswered question about stealing one bit from
> ctype.c::sane_ctype[] that kept the discussion in limbo.

That seems easy enough. Anybody got a 5 character abbreviation for special?

-brandon


 ctype.c           |   10 ++++++----
 dir.c             |    7 +------
 git-compat-util.h |   16 +++++++++-------
 3 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/ctype.c b/ctype.c
index d2bd38e..acb5f0f 100644
--- a/ctype.c
+++ b/ctype.c
@@ -9,18 +9,20 @@
 #undef SS
 #undef AA
 #undef DD
+#undef GS
 
 #define SS GIT_SPACE
 #define AA GIT_ALPHA
 #define DD GIT_DIGIT
+#define GS GIT_SPECIAL  /* \0, *, ?, [, \\ */
 
 unsigned char sane_ctype[256] = {
-	 0,  0,  0,  0,  0,  0,  0,  0,  0, SS, SS,  0,  0, SS,  0,  0,		/* 0-15 */
+	GS,  0,  0,  0,  0,  0,  0,  0,  0, SS, SS,  0,  0, SS,  0,  0,		/* 0-15 */
 	 0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,		/* 16-15 */
-	SS,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,		/* 32-15 */
-	DD, DD, DD, DD, DD, DD, DD, DD, DD, DD,  0,  0,  0,  0,  0,  0,		/* 48-15 */
+	SS,  0,  0,  0,  0,  0,  0,  0,  0,  0, GS,  0,  0,  0,  0,  0,		/* 32-15 */
+	DD, DD, DD, DD, DD, DD, DD, DD, DD, DD,  0,  0,  0,  0,  0, GS,		/* 48-15 */
 	 0, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA,		/* 64-15 */
-	AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA,  0,  0,  0,  0,  0,		/* 80-15 */
+	AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, GS, GS,  0,  0,  0,		/* 80-15 */
 	 0, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA,		/* 96-15 */
 	AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA,  0,  0,  0,  0,  0,		/* 112-15 */
 	/* Nothing in the 128.. range */
diff --git a/dir.c b/dir.c
index 92452eb..e6a2556 100644
--- a/dir.c
+++ b/dir.c
@@ -680,17 +680,12 @@ static int cmp_name(const void *p1, const void *p2)
  */
 static int simple_length(const char *match)
 {
-	const char special[256] = {
-		[0] = 1, ['?'] = 1,
-		['\\'] = 1, ['*'] = 1,
-		['['] = 1
-	};
 	int len = -1;
 
 	for (;;) {
 		unsigned char c = *match++;
 		len++;
-		if (special[c])
+		if (isspecial(c))
 			return len;
 	}
 }
diff --git a/git-compat-util.h b/git-compat-util.h
index 6ee3255..ac22409 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -326,14 +326,16 @@ static inline int has_extension(const char *filename, const char *ext)
 #undef tolower
 #undef toupper
 extern unsigned char sane_ctype[256];
-#define GIT_SPACE 0x01
-#define GIT_DIGIT 0x02
-#define GIT_ALPHA 0x04
+#define GIT_SPACE   0x01
+#define GIT_DIGIT   0x02
+#define GIT_ALPHA   0x04
+#define GIT_SPECIAL 0x08
 #define sane_istest(x,mask) ((sane_ctype[(unsigned char)(x)] & (mask)) != 0)
-#define isspace(x) sane_istest(x,GIT_SPACE)
-#define isdigit(x) sane_istest(x,GIT_DIGIT)
-#define isalpha(x) sane_istest(x,GIT_ALPHA)
-#define isalnum(x) sane_istest(x,GIT_ALPHA | GIT_DIGIT)
+#define isspace(x)   sane_istest(x,GIT_SPACE)
+#define isdigit(x)   sane_istest(x,GIT_DIGIT)
+#define isalpha(x)   sane_istest(x,GIT_ALPHA)
+#define isalnum(x)   sane_istest(x,GIT_ALPHA | GIT_DIGIT)
+#define isspecial(x) sane_istest(x,GIT_SPECIAL)
 #define tolower(x) sane_case((unsigned char)(x), 0x20)
 #define toupper(x) sane_case((unsigned char)(x), 0)
 
-- 
1.6.0.21.g35a2e
