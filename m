From: "Fabian Franz" <FabianFranz@gmx.de>
Subject: Re: [PATCH v3] submodule: Allow tracking of the newest revision of a 
 branch in a submodule
Date: Fri, 12 Dec 2008 01:21:01 +0100
Message-ID: <20081212002101.292020@gmx.net>
References: <1229009982-2701-1-git-send-email-git@fabian-franz.de>
 <7vbpvicuk2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: j.sixt@viscovery.net, hjemli@gmail.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, git@fabian-franz.de
X-From: git-owner@vger.kernel.org Fri Dec 12 01:22:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAvnj-0000mH-3F
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 01:22:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756559AbYLLAVI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 19:21:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756533AbYLLAVH
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 19:21:07 -0500
Received: from mail.gmx.net ([213.165.64.20]:39498 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755212AbYLLAVF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2008 19:21:05 -0500
Received: (qmail 19768 invoked by uid 0); 12 Dec 2008 00:21:01 -0000
Received: from 84.163.48.160 by www121.gmx.net with HTTP;
 Fri, 12 Dec 2008 01:21:01 +0100 (CET)
In-Reply-To: <7vbpvicuk2.fsf@gitster.siamese.dyndns.org>
X-Authenticated: #590723
X-Flags: 0001
X-Mailer: WWW-Mail 6100 (Global Message Exchange)
X-Priority: 3
X-Provags-ID: V01U2FsdGVkX1/F0aYW8IbFWUbSoWRkwDyLDhkZszr3g+KRJUA3DA
 08EbcqQl1LB2ihwESwSXoLTZkK5JKWgOHR6w== 
X-GMX-UID: WZx4cSRHYW0tcudwaGZpOfJ8amthc5vC
X-FuHaFi: 0.43
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102850>

> Fabian Franz <git@fabian-franz.de> writes:
> 
> > Submodules currently only allow tracking a specific revision
> > and each update in a submodule leads to a new commit in the
> > master repository. However some users may want to always track
> > the newest revision of a specific (named) tag or branch or HEAD.
> > For example the user might want to track a staging branch in all
> > submodules.
> 
> I initially liked the direction this is going, but I think the above
> rationale and the change to use 0{40} have impedance mismatch.  Your
> change is not a good way to go about "some users may want".  I'll discuss
> more on this below.

I do agree. I did like the idea of HEAD.gitlink also better and I even more like the assume-unchanged version, which works.

> It seems to me that what you are really after is to let you change the
> state of the subproject checkout in whatever way and have "git commit -a"
> in the superproject ignore that change.
> 
> I wonder if you can just set "assume unchanged" bit for the subproject
> gitlink in the index to achieve the same goal.
> 
> Or is there more to it?

Nope, that is it. I just did not knew that flag.

> > However I have both cases: Stable development, where I need one special
> > version and "wild" development, where I always want the newest published
> > one.
> 
> I do not think supporting both styles of development is a bad idea.
> 
> However, use of 0{40} in the index and the resulting commit object in the
> superproject means that this is a project-wide decision, not your personal
> preference.  It is not implausible that you would want to do a wild
> expeeriment in your own clone of a project that uses the "Stable
> development" approach (hence the upstream never would want to have 0{40}
> gitlink in its commits).

Yes, but at the same time I might want to record it permanently as a project decision or play at my own with it ...

So both styles should be supported.

> For example, suppose the project uses "Stable development" approach, and
> records the v1.0.0 of submodule at "sub/" in the superproject.  You are a
> contributor to that project, and would want to help them futureproof the
> superproject code to be forward compatible with the upcoming v1.2.0
> release of the subproject.  What would you do?
> 
>  * have a clone of superproject, with v1.0.0 submodule bound at "sub/";
> 
>  * go to "sub/", fetch and checkout v1.2.0-rc2;
> 
>  * go up, build using the updated submodule, see many failures in
>    supermodule build;
> 
>  * fix them up in a way that can work with both v1.0.0 and v1.2.0 of the
>    submodule, while making commits in logical steps, in the supermodule.
> 
> And you do not want to record the fact that you used v1.2.0-rc2 of the
> submodule at "sub/" in the commits you make in the supermodule, as you
> would want to label these commits as "futureproof for upcoming submodule
> v1.2.0".
> 
> But you cannot use your 0{40} trick, as sending that to the upstream of
> the superproject would break their "Stable development" policy.
> 
> I wonder if you can just set "assume unchanged" bit for the subproject
> gitlink in the index to achieve the same goal.  That would be a local
> operation, the gitlink would still point at v1.0.0 version of submodule,
> and "git commit -a" in the superproject won't make commits that flips
> everybody else's copy to use v1.2.0-rc2 of submodule.

Yes, that works. I tried it. I am now gonna change the patch to use this new approach and also re-think the workflow I want to support.
 
> > @@ -118,6 +118,10 @@ update::
> >  If the submodule is not yet initialized, and you just want to use the
> >  setting as stored in .gitmodules, you can automatically initialize the
> >  submodule with the --init option.
> > ++
> > +If you used --track or set the "track" option in .gitmodules this will
> > +automatically pull the newest updates from remote instead of tracking a
> > +specific revision.
> 
> "automatically pull" in the sense that it always goes to the remote, fetch
> and merge?  That sounds horribly broken.  You can never work disconnected?

Uhm, the same is already true for git submodule update. Before it checkouts the new branch it always does a fetch.

However I think what I really want (without) scripting via foreach is:

git checkout staging

In .gitmodules is from a personal (own branch) or project wide decision the fact documented that the submodules do track staging and one stable tag for example.

[module1]
track = staging
[module2]
track = staging
[module3]
track = stable-v1.0.0

And now I just do git submodule update and it fetches and afterwards checks out my local branch of staging and fast-forwards it.

However I do agree that in that workflow you always have to go online and that is not good.

But in my case I also want a developer to just be able to change to 

[module1]
track = feature_1
[module2]
track = feature_1
[module3]
track = stable-v1.0.0

to work in a feature branch in two submodules at once.

So I am gonna rethink this design.

> > @@ -159,6 +163,10 @@ OPTIONS
> >  --branch::
> >  	Branch of repository to add as submodule.
> >  
> > +-t::
> > +--track::
> > +	Branch/Tag/HEAD of repository to track in a submodule.
> > +
> 
> How does the branch parameter to the --track option interact with the
> branch parameter to the --branch option?  Does an end user typically set
> them to the same branch?  Or would these parameters almost always point at
> different branchesof the remote repository?  What are the reasons for the
> end user to choose one parameter value for the --branch option and a
> different parameter value for the --track option?

--branch is always checking out just the branch on the initial add and then the branch head is of course recorded as commit in the index.

However I found that option just helpful for creating a first initial commit already in a branch.

For later submodule init or updates this has no effect.

> > diff --git a/git-submodule.sh b/git-submodule.sh
> > index 2f47e06..16df528 100755
> > --- a/git-submodule.sh
> > +++ b/git-submodule.sh
> > ...
> > @@ -197,12 +203,14 @@ cmd_add()
> >  		(unset GIT_DIR; cd "$path" && git checkout -f -q ${branch:+-b
> "$branch" "origin/$branch"}) ||
> >  		die "Unable to checkout submodule '$path'"
> >  	fi
> > +	test -n "$track" && printf '160000
> 0000000000000000000000000000000000000000\t%s\n' "$path" | git update-index --index-info
> >  
> 
> You have many overlong lines due to the 0{40} constant string in your
> patch.  Have a
> 
> 	null_sha1=0000000000000000000000000000000000000000
> 
> at the beginning of the script, and rewrite the above like this:
> 
> 	test -n "$track" &&
>                 printf '160000 %s\t%s\n' "$null_sha1" "$path" |
>                 git update-index --index-info
> 
> or even like this:
> 
> 	if test -n "$track"
>         then
>                 printf '160000 %s\t%s\n' "$null_sha1" "$path" |
>                 git update-index --index-info
> 	fi
> 
> Use of $null_sha1 throughout the script will make things easier to read
> and at the same time make it less error prone as well for "git submodule"
> developers.

Okay, thanks that is a good practice.

> > @@ -345,11 +357,29 @@ cmd_update()
> >  			then
> >  				force="-f"
> >  			fi
> > +			pull=
> > +			if [ "$sha1" = "0000000000000000000000000000000000000000" ]
> > +			then
> > +				track=$(git config submodule."$name".track)
> > +				: ${track:="master"}
> 
> In the v2 patch this used to point at "HEAD".  What made you change your
> mind?

Because at the moment HEAD would be created as local branhc, which is horribly broken.

> > +				# if the local branch does not yet exist, create it
> > +				( unset GIT_DIR; cd "$path"; git-show-ref --heads --tags -q
> "$track" || git branch --track "$track" "origin/$track" )
> 
> No error checking?
> 
> 	(
>         	unset GIT_DIR;
>                 cd "$path" &&
>                 git show-ref --heads --tags -q "$track" ||
>                 git branch --track "$track" "origin/$track"
> 	) || barf
> 
> The ';' after unset is intentional; some shells reports failure when you
> unset an unset variable.

Okay, thanks. I didn't know that.

> 
> > +				sha1="$track"
> > +				pull=1
> 
> I tend to prefer booleans in shell scripts spelled like boolean, e.g.
> 
> 	pull=yes

Good idea.

> 
> > +			fi
> > +
> >  			(unset GIT_DIR; cd "$path" && git-fetch &&
> >  				git-checkout $force -q "$sha1") ||
> >  			die "Unable to checkout '$sha1' in submodule path '$path'"
> >  
> >  			say "Submodule path '$path': checked out '$sha1'"
> > +
> > +			if [ "$pull" = "1" ]
> > +			then
> > +				# Now pull new updates from origin
> > +				( unset GIT_DIR; cd "$path"; git-pull ) || die "Unable to pull in
> submodule path '$path'"
> 
> No error checking?

In v3 there should be ... And I even see error checking in the above ...

> 
> > +			fi
> > +
> >  		fi
> >  	done
> >  }
> > @@ -596,7 +626,8 @@ cmd_status()
> >  		set_name_rev "$path" "$sha1"
> >  		if git diff-files --quiet -- "$path"
> >  		then
> > -			say " $sha1 $path$revname"
> > +			track=$(git config submodule."$name".track)
> > +			say " $sha1 $path$revname${track:+ (tracking "$track")}"
> >  		else
> >  			if test -z "$cached"
> >  			then
> > diff --git a/read-cache.c b/read-cache.c
> > index 8579663..0c14b68 100644
> > --- a/read-cache.c
> > +++ b/read-cache.c
> > @@ -137,6 +137,11 @@ static int ce_compare_gitlink(struct cache_entry
> *ce)
> >  	 */
> >  	if (resolve_gitlink_ref(ce->name, "HEAD", sha1) < 0)
> >  		return 0;
> > +
> > +	// To be able to track newest revision
> > +	if (is_null_sha1(ce->sha1))
> > +		return 0;
> > +
> 
> I think the comment is wrong, as it is not about newness at all.
> 
> 	/* ignore changes in the submodule path */
> 
> would be more appropriate.

Yes, I do agree. I am now changing first to --assume-unchanged so this is made unnecessary.

I'll write a PATCH/RFC next.

Thank you for your detailed feedback,

Best Wishes,

Fabian
