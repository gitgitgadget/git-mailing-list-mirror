From: =?KOI8-R?B?98HTyczJyiDtwcvB0s/X?= <einmalfel@gmail.com>
Subject: [PATCH 1/2] merge-base: fix duplicates and not best ancestors in output
Date: Sat, 28 Dec 2013 14:22:26 +0400
Message-ID: <CABEtfDFu=Fc0SXbyFctEyiMCJwqxP25K9mdVhAB0X_vKHxvW_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: jrnieder@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 28 11:22:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vwr2P-0006iH-4W
	for gcvg-git-2@plane.gmane.org; Sat, 28 Dec 2013 11:22:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144Ab3L1KW3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Dec 2013 05:22:29 -0500
Received: from mail-we0-f179.google.com ([74.125.82.179]:50797 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750852Ab3L1KW2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Dec 2013 05:22:28 -0500
Received: by mail-we0-f179.google.com with SMTP id q59so8664285wes.24
        for <git@vger.kernel.org>; Sat, 28 Dec 2013 02:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=hW752qOxlfaz/3mo9g///QUA04R0QE9gNF08NPlzDlE=;
        b=m4JYEScFgGjXyh+dZzMxjut1tBTTu/8dxblATtQ20ZqWiO8yMUCPssdxzEn4eyZCt/
         wO2JWZ2ixsq256kmejJC0w0yzqukvydIa6x+FA1HoekmHR8wsiZoELMA3O/wdz9Q0MW/
         WJX4CLyfBAt2rASRpKcuhrmT0M0VsKGSifBAx1YaymvNH3aWyruVL44IGlYRQ8OWdXOH
         PKNjwhfWuEHowz5oKni316qwqJngqtZrPf7/8DfaGvbu7fNeQ12k8q8jAAOQgD1vb1T1
         0Q/9+5JPZIGAzaUIQivtHCdqY3s0ZmI265LcV7cUeGfYW37uFCiAWvp4Cy9X+0S7vDGM
         3yDg==
X-Received: by 10.180.77.49 with SMTP id p17mr36358699wiw.30.1388226146782;
 Sat, 28 Dec 2013 02:22:26 -0800 (PST)
Received: by 10.194.123.228 with HTTP; Sat, 28 Dec 2013 02:22:26 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239770>

Hi there!
First of all: I'm new to mailing-lists, sorry if I'm doing it wrong.

I've found a bug in git merge-base, causing it to show not best common
ancestors and duplicates under some circumstances (example is given in
attached test case).
Problem cause is algorithm used in get_octopus_merge_bases(), it
iteratively concatenates merge bases, and don't care if there are
duplicates or decsendants/ancestors in result.
What I suggest as a solution is to simply reduce bases list after
get_octopus_merge_bases().

Here is the fix:

---
 builtin/merge-base.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index e88eb93..d6ad330 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -44,19 +44,19 @@ static struct commit *get_commit_reference(const char
*arg)
  return r;
 }

-static int handle_octopus(int count, const char **args, int reduce, int
show_all)
+static int handle_octopus(int count, const char **args, int reduce_only,
int show_all)
 {
  struct commit_list *revs = NULL;
  struct commit_list *result;
  int i;

- if (reduce)
+ if (reduce_only)
  show_all = 1;

  for (i = count - 1; i >= 0; i--)
  commit_list_insert(get_commit_reference(args[i]), &revs);

- result = reduce ? reduce_heads(revs) : get_octopus_merge_bases(revs);
+ result = reduce_heads(reduce_only ? revs : get_octopus_merge_bases(revs));

  if (!result)
  return 1;
-- 
1.8.3.1
