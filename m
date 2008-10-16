From: Christian Jaeger <christian@pflanze.mine.nu>
Subject: Re: [gambit-list] Separating generated files?
Date: Thu, 16 Oct 2008 14:00:45 +0200
Message-ID: <48F72CED.6030508@pflanze.mine.nu>
References: <E6D34628-783D-4597-8B00-C10F27F63BE2@iro.umontreal.ca>	<48F5D86B.6040501@pflanze.mine.nu>	<fcaeb9bf0810150754s613f2c44pd8341711d9d73f73@mail.gmail.com> <vpqiqrt3mgs.fsf@bauges.imag.fr> <48F61D77.3080100@drmicha.warpmail.net> <48F62834.9080102@pflanze.mine.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Marc Feeley <feeley@iro.umontreal.ca>,
	Gambit List <Gambit-list@iro.umontreal.ca>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Oct 16 14:02:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqRYL-00086Y-4x
	for gcvg-git-2@gmane.org; Thu, 16 Oct 2008 14:02:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755890AbYJPMAu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 08:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755939AbYJPMAt
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 08:00:49 -0400
Received: from ethlife-a.ethz.ch ([129.132.49.178]:38908 "HELO ethlife.ethz.ch"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1754367AbYJPMAs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 08:00:48 -0400
Received: (qmail 3346 invoked from network); 16 Oct 2008 12:00:46 -0000
Received: from unknown (HELO elvis-jaeger.mine.nu) (127.0.0.1)
  by localhost with SMTP; 16 Oct 2008 12:00:46 -0000
Received: (qmail 27236 invoked from network); 16 Oct 2008 12:00:45 -0000
Received: from unknown (HELO ?127.0.0.1?) (10.0.5.1)
  by elvis-jaeger.mine.nu with SMTP; 16 Oct 2008 12:00:45 -0000
User-Agent: Mozilla-Thunderbird 2.0.0.16 (X11/20080724)
In-Reply-To: <48F62834.9080102@pflanze.mine.nu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98372>

I wrote:
> Michael J Gruber wrote:
>> I wonder whether a clever use of "excludes" and GIT_DIR would allow
>> tracking the different filesets in the same dir, but using different
>> repos. I'm just afraid it's a fragile setup, in the sense that it relies
>> on config stuff which is not tracked (and thus not reproduced
>> automatically on clone).
>
> I expect that using a superproject repository to tie together the two 
> repositories is good and necessary because it is the link that allows 
> to specify which commit in the repo of generated files belongs 
> together with a commit in the repo of source files. So just using two 
> separate repositories without making them submodules of a superproject 
> does not seem to be a good idea to me.

(In the meantime I've read the following pages:
http://nopugs.com/2008/09/06/ext-tutorial
http://nopugs.com/2008/09/04/why-ext
http://flavoriffic.blogspot.com/2008/05/managing-git-submodules-with-gitrake.html
(a post to the latter article suggests to use subtree merging instead, 
but that would be a very bad match for our use case; the mentioned 
problem of merging of the git superproject makes me think, though--the 
superproject could be updated only by the one person doing the publish 
onto the public repository, but then it leaves the problem of handling 
merges by developers completely unsolved.)
)

I'm starting to think that maybe a better idea than the 
superproject+2submodules approach would be just using the two 
repositories ("source" + "build"), and storing the linking information 
inside the "build" repository (by adding the source repository commitid 
to every commit message in the build repository [or using tags, but that 
doesn't seem a better idea]), and use a program that is able to check 
out the matching "build" repository for a given "source" repository 
checkout.

I'm willing to write this program (let's call it 
"intergit-find-matching-commit-in" for the purpose of this email); 
question: which language to write it in, is Perl good? (C would be a 
hassle for Windows users because of the C compiler requirement; shell 
may be too limited.)

Description of the workings in more detail:

- one would work with the "source" repository just as one would with any 
project only employing one repository; do some changes to the project, 
commit them, test them (includes regeneration of generated files);

- once in a while one would commit the current generated files in the 
"build" repository; by either (a) using a make target (like "make 
commit_generated") which runs something like

  eval "cd build; git commit -m 'generated files for source repository 
commit `git rev-parse HEAD`'"

or (b) setting up a build/.git/hooks/commit-msg script which appends 
'generated files for source repository commit `git rev-parse HEAD`' line 
to the commit message given from running "cd build; git commit -a" manually.

- for publication, one would push both the "source" as well as the 
"build" repository (i.e. "cd build; git push; cd ..; git push")

- for checkout (our "make update" make target), about the following 
would happen:

   git pull
   eval "(cd build; git checkout `intergit-find-matching-commit-in build`)"

where "intergit-find-matching-commit-in build" would first refresh an 
index of the links (iterate over all unseen commits, parse commit 
messages for /source repository commit (\w+)/ and store $1 => 
$commitid_in_build_repo mappings in the index), then go through "git log 
--pretty=format:%H" (should I also specify --topo-order (or 
--date-order)?) looking up the commitids in the index, stopping at the 
first match and outputting the mapped $commitid_in_build_repo.

This way, the "latest" or "probably best-matching" corresponding commit 
in the "build" repo can always be found, even if the "source" repo is 
ahead, which should allow building the compiler even if none is 
previously installed. This workflow seems more natural than the 
superproject+submodules approach, and it seems to entail no hassle with 
merge issues (only the "source" repo really needs proper merging; 
merging the "build" repo would only be worthwhile for maintaining the 
history, and as mentioned if there are conflicts, one would probably 
usually just regenerate the files there; there's no need to maintain 
linking info (with associated merge etc issues) in a separate entity 
(superproject) anymore, and during development, commits to the "build" 
repo need only be done if backwards-incompatible changes have been 
introduced).

Does anyone else think this is sane/interesting? Should I go ahead 
implementing this? Any comments, like on how the interface of the 
intergit-find-matching-commit-in tool should look like?

Christian.
