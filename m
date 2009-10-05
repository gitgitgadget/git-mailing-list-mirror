From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] Add the --submodule-summary option to the diff option
 family
Date: Mon, 05 Oct 2009 13:22:19 +0200
Message-ID: <4AC9D6EB.8090002@web.de>
References: <cover.1254668669u.git.johannes.schindelin@gmx.de> <67a884457aeaead275612be10902a80726b2a7db.1254668669u.git.johannes.schindelin@gmx.de> <7vbpkmn6oi.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0910051027010.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 05 13:30:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MullZ-000620-E4
	for gcvg-git-2@lo.gmane.org; Mon, 05 Oct 2009 13:30:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758761AbZJELX5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2009 07:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752528AbZJELX4
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Oct 2009 07:23:56 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:48154 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758742AbZJELX4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2009 07:23:56 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate02.web.de (Postfix) with ESMTP id 590A812977B9C;
	Mon,  5 Oct 2009 13:22:20 +0200 (CEST)
Received: from [80.128.124.99] (helo=[192.168.178.26])
	by smtp08.web.de with asmtp (WEB.DE 4.110 #314)
	id 1Mule0-0007W3-00; Mon, 05 Oct 2009 13:22:20 +0200
User-Agent: Thunderbird 2.0.0.23 (X11/20090812)
In-Reply-To: <alpine.DEB.1.00.0910051027010.4985@pacific.mpi-cbg.de>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+RiZBchhh7wU8HxN3yIhetntQ55hcpGEbRP3Yc
	YDpVO8rutgOjKr1DyFBQSX7+B04Gt+TEhhMyixfFrPi3R0G6E9
	87YluHmh+5gJqwvbctUQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129552>

First: I already coded a test and am using this patch in git gui and
gitk (there was no way git submodule summary would have worked for
gitk, now it does). Looking really good, will post when this patch
solidifies ...

Johannes Schindelin schrieb:
> That's something I will gladly do after I adjusted the format to look a 
> bit more like "git submodule summary" (Jens noticed 4 differences), and 
> after Jens patched git-submodule.sh to use the diff mode instead.

Actually there are two more and Junio pointed out #7: submodule summary
uses --first-parent and we don't (My testcases don't contain merges, so
i didn't notice).

The difference that is most obvious and was unintended is that the
shortlog is indented by four spaces instead of two. I appended an
interdiff to fix that.

As with the other six, i am not really sure if we should just copy the
behaviour of git submodule summary.


> IOW in hindsight I would like to add the prefix "RFC/RFH" to the subject.

FullAck.

First some examples for the current behaviour (with the patch below
applied):

$ git diff --submodule-summary
Submodule sub 5431f52..3f35670:
  > sub3
$ git submodule summary --files
* sub 5431f52...3f35670 (1):
  > sub3

$ git diff-index --submodule-summary HEAD -p
Submodule sub 81d7059..3f35670:
  > sub3
  > sub2
$ git submodule summary
* sub 81d7059...3f35670 (2):
  > sub3
  > sub2

[$ git diff --cached --submodule-summary HEAD
Submodule sub 81d7059..5431f52:
  > sub2
$ git submodule summary --cached
* sub 81d7059...5431f52 (1):
  > sub2

$

So the differences are:

1) Dscho replaced the leading '*' with the more explicit "Submodule"
   I like the explicit version.

2) submodule summary prints out how many shortlog entries are following
3) submodule summary adds a newline after the shortlog
4) submodule summary uses --first-parent
   No idea about the intention here. Lars?

5) submodule summary always prints three '.' between the hashes
   Seems like submodule summary didn't do the hassle for performance
   reasons. But for consistency i would prefer the new version as we
   use it all over the place, no?

6) submodule summary can limit the number of shortlog lines
   Hm, i want to see them all. Any users of that -n option?


To take this a bit further: It might be a good idea to let git diff
generate output for submodules that is consistent with that for regular
files. So instead of:

git diff --cached --submodule-summary HEAD -p
Submodule sub 81d7059..5431f52:
    > sub2

we could produce:

diff --git a/sub b/sub
index 81d7059..3f35670 160000
--- a/sub
+++ b/sub
@@ -1 +1 @@
-Subproject commit 81d70590e6aaf9f995ebf4d6d284a7ebb355398d
+Subproject commit 3f356705649b5d566d97ff843cf193359229a453
  > sub2

(This is the output of a git diff without the --submodule-summary option
with an appended shortlog)

I like the second variant (mainly because of consistency). Opinions?



And here the promised indentation depth fix interdiff:
------------------8<-----------------
diff --git a/submodule.c b/submodule.c
index 3f2590d..11fce7d 100644
--- a/submodule.c
+++ b/submodule.c
@@ -42,7 +42,7 @@ void show_submodule_summary(FILE *f, const char *path,
        struct commit_list *merge_bases, *list;
        const char *message = NULL;
        struct strbuf sb = STRBUF_INIT;
-       static const char *format = "    %m %s";
+       static const char *format = "  %m %s";
        int fast_forward = 0, fast_backward = 0;

        if (add_submodule_odb(path))
