Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Greylist: delayed 478 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 24 Nov 2023 08:47:12 PST
Received: from einhorn-mail-out.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F91510FB
	for <git@vger.kernel.org>; Fri, 24 Nov 2023 08:47:12 -0800 (PST)
X-Envelope-From: oliver@first.in-berlin.de
X-Envelope-To: <git@vger.kernel.org>
Received: from authenticated.user (localhost [127.0.0.1]) by einhorn.in-berlin.de  with ESMTPSA id 3AOGdCwU393758
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
        for <git@vger.kernel.org>; Fri, 24 Nov 2023 17:39:12 +0100
Date: Fri, 24 Nov 2023 17:39:12 +0100
From: Oliver Bandel <oliver@first.in-berlin.de>
To: git@vger.kernel.org
Subject: "git overlay" - command for overlaying branches
Message-ID: <n46dskd3hudzssaam56jesxr5elzdvs3asurqvbxkgsdcqitjs@qlufclnnjpsq>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hello,

I'm adressing the problem with files separated from the main branch(es),
which currently might be (more or less) solved with either submodules or subtrees.
I want to suggest a new command here.

As usecase-example I assume a project that has 'branch_a' and 'branch_b'
with some files may be identical, some different between them.
I assume that the (classical) way the files are handled
by belonging to those branches is intended.

Then say later I want to add more files to these branches,
but don't want to commit them in either of these existing branches.
Instead a branch 'branch_addons' is created, which solely contains
files that are used in 'branch_a' as well as 'branch_b'.

Assume there is a command 'git overlay' which overlays one branch on top of another branch,
so that the working dir contains files of both branches (with the overlayed on-top
having priority in hiding all the other files of same name in the working dir).
The files in the working dir are regarded as being members of the branches,
they are coming from initially (with the (last) overlayed branch as priority).

This, I guess, would solve the use case of the submodules/subtree problem.

Example:

Assuming only the files of the according branches are in the working dir.

branch_a has these files:
  a1.txt
  a2.txt
  common.txt


branch_b has these files:
  b1.txt
  b2.txt
  common.txt


branch_addons has these files:

  addon_1.txt
  addon_2.txt



CASE_1:
When sitting in 'branch_a' and typing 'git overlay branch_addons' I see these files:

  a1.txt
  a2.txt
  common.txt
  addon_1.txt
  addon_2.txt


CASE_2:
Would I instead be sitting in 'branch_b' and typing 'git overlay branch_addons' I see these files:

  b1.txt
  b2.txt
  common.txt
  addon_1.txt
  addon_2.txt

Changing files and then adding/committing them would apply add/commit on the branches,
where these files are comming from.

This means, in CASE_1, adding/committing changes of files from 'branch_a' would work on 'branch_a',
adding/committing changes of files from 'branch_addons' would work on 'branch_addons'.

In CASE_2, adding/committing changes of files from 'branch_b' would work on 'branch_b',
adding/committing changes of files from 'branch_addons' would work on 'branch_addons'.


If 'branch_addons' would also contain a file common.txt, then this file would be
residing in the working dir (hiding all other common.txt) and
changing/adding/committing it, would result in the 'branch_addons' common.txt
being changed.

A 'git unoverlay' or 'git unoverlay branch_addons' or 'git overlay --rm'
or 'git overlay --off' would disable the overlay, which means only the main branch
(here 'branch_a' or 'branch_b') would be checked out.

A switch of the branch (checkout/switch) might automatically un-overlay all of
the overlayed branches, or might be forbidden until an explicit un-overlay
would be done. (maybe configurable behaviour)

I assume that more than one overlay would be possible.
Of course the order of applying the overlays determenines, what branches the
files in the working dir are associated with (and checked out from).


Other use cases of course could use programming files.
The main branch might contain some interface files (*.h, *.mli, ...)
and the overlays the implementation (*.c, *.ml, ...).

Then switching the implementation for the same interface
(assuming no interface files are in the overlay-branches)
would just be one git command.


Additionally it would be good to have an easy way to move a file from one branch to another
branch (for example from one of the main branches to an overlay or vice versa).
If common.txt in the above example does not differ between 'branch_a' and
'branch_b', it might make sense to move it to maybe a branch 'branch_common', which
might be used as overlay as well (or as a base branch instead, making branhc_a and 'branch_b'
possible candidates for being overlayed).


I suggest considering such an overlay feature for git in the future.
If there are problems lurking in the background here
(for example when considering merges, rebasing and such stuff),
or if anything would fit in nicely, I can't see right now.


Ciao,
  Oliver

P.S.:

  Instead of "overlay" I first had in mind "mount" and "unmount" as name,
  but the name "overlay" is better choice, even though "unoverlay" is somewhat intricate.
