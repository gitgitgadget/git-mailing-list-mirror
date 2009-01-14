From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH take 3 0/4] color-words improvements
Date: Wed, 14 Jan 2009 20:28:33 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901142028010.3586@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0901112057300.3586@pacific.mpi-cbg.de> <alpine.DEB.1.00.0901112059340.3586@pacific.mpi-cbg.de> <200901120947.13566.trast@student.ethz.ch> <7vprisj26i.fsf@gitster.siamese.dyndns.org> <adf1fd3d0901140500j10556a1as6370d40d766f1899@mail.gmail.com>
 <alpine.DEB.1.00.0901141840100.3586@pacific.mpi-cbg.de> <87ljtdk9b3.fsf@iki.fi> <87d4epk96e.fsf@iki.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Wed Jan 14 20:29:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNBQW-0000Ky-Fa
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 20:29:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753572AbZANT15 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 14:27:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753130AbZANT15
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 14:27:57 -0500
Received: from mail.gmx.net ([213.165.64.20]:34161 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753111AbZANT14 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 14:27:56 -0500
Received: (qmail invoked by alias); 14 Jan 2009 19:27:46 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp009) with SMTP; 14 Jan 2009 20:27:46 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19x6axhuclxKWKw2hLTo2m8nMPnW4kH4BR6KoLNHP
	08zIzgr19I+5Km
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <87d4epk96e.fsf@iki.fi>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.48
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105685>

Hi,

On Wed, 14 Jan 2009, Teemu Likonen wrote:

> Teemu Likonen (2009-01-14 20:54 +0200) wrote:
> 
> > With --color-diff=a+ it looks like 
> 
> Obviously I meant --color-words=a+

Heh,  I missed that, even...  Thanks for the report!

-- snipsnap --
[WILL BE SQUASHED INTO 4/4] Fix find_word_boundaries()

Since newlines cannot be part of words, we have to stop at newlines even
if the regular expression's match contains one.

Of course, I fscked up the range where to look for the newline when I
changed the function from find_word_boundary().
---
 diff.c                |    2 +-
 t/t4034-diff-words.sh |   20 ++++++++++++++++++++
 2 files changed, 21 insertions(+), 1 deletions(-)

diff --git a/diff.c b/diff.c
index d5d7171..1408717 100644
--- a/diff.c
+++ b/diff.c
@@ -384,7 +384,7 @@ static int find_word_boundaries(mmfile_t *buffer, regex_t *word_regex,
 		regmatch_t match[1];
 		if (!regexec(word_regex, buffer->ptr + *begin, 1, match, 0)) {
 			char *p = memchr(buffer->ptr + *begin + match[0].rm_so,
-					'\n', match[0].rm_eo);
+					'\n', match[0].rm_eo - match[0].rm_so);
 			*end = p ? p - buffer->ptr : match[0].rm_eo + *begin;
 			*begin += match[0].rm_so;
 			return *begin >= *end;
diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
index 0ed7e53..1137131 100755
--- a/t/t4034-diff-words.sh
+++ b/t/t4034-diff-words.sh
@@ -83,4 +83,24 @@ test_expect_success 'word diff with a regular expression' '
 
 '
 
+echo 'aaa (aaa)' > pre
+echo 'aaa (aaa) aaa' > post
+
+cat > expect <<\EOF
+<WHITE>diff --git a/pre b/post<RESET>
+<WHITE>index c29453b..be22f37 100644<RESET>
+<WHITE>--- a/pre<RESET>
+<WHITE>+++ b/post<RESET>
+<BROWN>@@ -1 +1 @@<RESET>
+aaa (aaa)<GREEN> aaa<RESET>
+EOF
+
+test_expect_success "Teemo's example" '
+
+	test_must_fail git diff --no-index --color-words='a+' pre post > output &&
+	decrypt_color < output > output.decrypted &&
+	test_cmp expect output.decrypted
+
+'
+
 test_done
-- 
1.6.1.295.gb16478
