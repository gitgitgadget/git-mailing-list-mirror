From: "Jonas Fonseca" <jonas.fonseca@gmail.com>
Subject: Re: [tig] Feeding specific revisions to tig
Date: Wed, 6 Aug 2008 13:06:51 +0200
Message-ID: <2c6b72b30808060406u10d7b332g22ea28fe5470ddb1@mail.gmail.com>
References: <ae63f8b50806041152v11a2997y9411c5ea3ebc9598@mail.gmail.com>
	 <20080604192916.GB17327@sigill.intra.peff.net>
	 <ae63f8b50806041304i20de789ej492681f4b9306934@mail.gmail.com>
	 <20080604230858.GA27136@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jean-Baptiste Quenot" <jbq@caraldi.com>, git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 06 13:08:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQgs1-0004xc-VQ
	for gcvg-git-2@gmane.org; Wed, 06 Aug 2008 13:07:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756765AbYHFLGz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2008 07:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756739AbYHFLGz
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Aug 2008 07:06:55 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:46579 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756751AbYHFLGy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2008 07:06:54 -0400
Received: by ug-out-1314.google.com with SMTP id h2so176536ugf.16
        for <git@vger.kernel.org>; Wed, 06 Aug 2008 04:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=egBzgrbSQFUiZrd0YuDynRDfujDX6dh6RoGv0vThg/g=;
        b=Mu9zoRbXV+7pd9f/QyPLDlcqaB8s54cC2N/hL+CKgIHtHEfgvv+h4LSx01H2vBSfkL
         L1cjnrsEjpsYZHdwoXV83nd9j11Fn+rEmWazGUPx1HSoy2/0hIGmVQh5+PJ31wtnZJes
         gFcr1Pzp+V2m+9Yc3pxDHO/q2JKpxfuDsWymI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=lueiz87HHZtvIzAOLgTJqTMihpZF/7SdDDnKhbPA3AIROOEwxjKISFOCPzUqXQyGpZ
         VE+M//szL5uObfaG9a7ZKJ4OoD+HBwXGZOIEG/C+cfrpbx1IERDMCWV8Go2XAqYJYF/N
         dqjs70JgmLSKeLOxrXWuvP06WruIP81pzrOu8=
Received: by 10.125.161.1 with SMTP id n1mr114962mko.14.1218020812005;
        Wed, 06 Aug 2008 04:06:52 -0700 (PDT)
Received: by 10.125.115.9 with HTTP; Wed, 6 Aug 2008 04:06:51 -0700 (PDT)
In-Reply-To: <20080604230858.GA27136@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91503>

Sorry for restarting this old thread ...

On Thu, Jun 5, 2008 at 01:08, Jeff King <peff@peff.net> wrote:
> On Wed, Jun 04, 2008 at 10:04:45PM +0200, Jean-Baptiste Quenot wrote:
>
>> Thanks for the suggestion.  However, my list of commits is too long,
>> the shell errors out with "tig: command too long".  I'd like to feed
>> tig with a list of commits from stdin, or from a file.
>>
>> Something like: ... | tig --no-walk -F -
>>
>> Which means: take the list of revisions from specified file, or here -
>> for stdin, a la grep.
>
> Ah. Adding "-F" probably wouldn't be that much work, but tig spawns "git
> log" internally, so you would probably end up with the same problem
> there. Converting tig to use "git rev-list --stdin" would fix that, but
> is probably a bit of major surgery.

git-rev-list expects a commit as an argument while git-log does not. I
have been gradually changing the option parsing code to move towards
using git-rev-parse for splitting up arguments so it will be possible
to support refreshing better and pass user arguments to the diff
engine etc. When the code will get there it probably won't be that
hard to switch to use git-rev-list.

I actually added something that let's you alter the command executed
for each view. So here is another possibility that can be used:

function tignowalk ()
{
   tmp=$(mktemp) # or .git/tigfiles or similar
   # Safe stuff from "stdin" and run tig with custom rev-list command
   cat > "$tmp
   TIG_MAIN_CMD="git rev-list --pretty=raw --no-walk --stdin < $tmp"
tig < /dev/tty
   rm "$tmp"
}

And then:

   printf "tig-0.2\ntig-0.1" | tignowalk

On Wed, Jun 4, 2008 at 22:04, Jean-Baptiste Quenot <jbq@caraldi.com> wrote:
> 2008/6/4 Jeff King <peff@peff.net>:
>>     Though it seems there are a few display artifacts. If I do
>>
>>       tig --no-walk tig-0.1 tig-0.2
>>
>>     I get the 2 commits I expect, but also two "extra" blank
>>     commits at the bottom.
>
> I confirm there are extra blank lines at the bottom.  As many as real
> commit lines.

The problem is that --no-walk doesn't seem to play nice with the
--boundary flag that tig add by default. When the user requests
--no-walk boundary commits are probably not interesting. My fix below
has more information. I don't know if having only the "commit" line
show up is a bug in git. At least there are no tests to confirm this
or not.

commit ad9f9954419b5d3f595580d5184db59a00711f92
Author: Jonas Fonseca <fonseca@diku.dk>
Date:   Tue Aug 5 23:40:21 2008 +0200

    Clean up incomplete commits from main view listed for --no-walk

    When --no-walk is given on the command line by the user it causes
    boundary commits to be output with just the commit line, i.e:

      > git rev-list --pretty=raw --boundary --no-walk HEAD
      commit 60e8ea56880fc2e42008075d516c356ef605bc60
      tree 5b76086e4deaf62d3f7baffc6f49840f61d4e79c
      parent 145194bdfc8bf0b58185bbe28bc0097ce429de4d
      author Jonas Fonseca <fonseca@diku.dk> 1217797175 +0200
      committer Jonas Fonseca <fonseca@diku.dk> 1217797402 +0200

          Remove the global opt_request variable

      commit -145194bdfc8bf0b58185bbe28bc0097ce429de4d

diff --git a/NEWS b/NEWS
index b7a8df1..d93fb04 100644
--- a/NEWS
+++ b/NEWS
@@ -22,6 +22,7 @@ Bug fixes:
    keybinding to launch the merge tool in the status view.
  - Fix problem with $(cmd) usage in shell code. Some shells (jsh)
    installed as /bin/sh does not support it.
+ - Do not show incomplete boundary commits when --no-walk is used.
  - Documentation: Rename gitlink macro to support AsciiDoc 8.2.3.

 tig-0.11
diff --git a/tig.c b/tig.c
index 6846519..6b111e4 100644
--- a/tig.c
+++ b/tig.c
@@ -4983,6 +4983,14 @@ main_read(struct view *view, char *line)
 	if (!line) {
 		if (!view->lines && !view->parent)
 			die("No revisions match the given arguments.");
+		if (view->lines > 0) {
+			commit = view->line[view->lines - 1].data;
+			if (!*commit->author) {
+				view->lines--;
+				free(commit);
+				graph->commit = NULL;
+			}
+		}
 		update_rev_graph(graph);
 		return TRUE;
 	}

-- 
Jonas Fonseca
