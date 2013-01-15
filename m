From: Max Horn <max@quendi.de>
Subject: Re: [PATCH] remote-hg: store converted URL
Date: Tue, 15 Jan 2013 19:10:01 +0100
Message-ID: <B35B3EA6-F01B-46D8-AC3D-0F7C8A45A06B@quendi.de>
References: <1357760618-81222-1-git-send-email-max@quendi.de> <7vmwwbd43o.fsf@alter.siamese.dyndns.org> <64C81CD0-960A-47F2-89FC-8D3126B1F4D5@quendi.de> <7vzk0a4ekj.fsf@alter.siamese.dyndns.org> <7vr4lm4cez.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 19:10:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvAxx-0007Fw-VU
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 19:10:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280Ab3AOSKH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 13:10:07 -0500
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:40029 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750698Ab3AOSKG convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 13:10:06 -0500
Received: from ip-178-200-227-112.unitymediagroup.de ([178.200.227.112] helo=zanovar.fritz.box); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1TvAxV-0007jZ-Jo; Tue, 15 Jan 2013 19:10:01 +0100
In-Reply-To: <7vr4lm4cez.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1283)
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1358273406;17f98571;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213656>


On 15.01.2013, at 17:51, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Max Horn <max@quendi.de> writes:
>> ...
>>> See also the discussion (yeah, this time a real one ;-) leading to this:
>>>  https://github.com/felipec/git/issues/2
>>> ...
> 
> If I understand correctly, the $backend::$opaqueToken is a contract
> between the remote-helper and the remote-$backend

Just to clarify: What is the "remote-helper" ? So far, I thought of this being a contract between git (or some part of git), and remote-$backend (i.e. remote-hg in this case). 


> that says "When
> user wants to interact with the same (foreign) repository, we agreed
> to let her use 'origin' nickname.  The remote-helper looks up this
> opaque token that corresponds to 'origin' and gives it to the
> remote-$backend, and whatever is in the opaque token should be
> sufficient for the remote-$backend to figure out how to proceed from
> there".

Supposing that I interpret "remote-helper" correctly, that sounds about right to me.

> 
> But in this hg::../over/there case, it seems that string is not
> sufficient for remote-hg to do so and the contract is broken.

One could put it that way.

> 
> When "git clone $backend::$opaqueToken repo" is run in /dir/ecto/ry,
> and then subsequent "git fetch origin" will be run in (a
> subdirectory of) /dir/ecto/ry/repo, but anything relative to
> /dir/ecto/ry will not work once you go inside /dir/ecto/ry/repo.
> The "create a new repository here" argument could even be an
> absolute path to a totally different place, so if the
> remote-$backend wants to use $opaqueToken as anything relative to
> the $(cwd) when "git clone" was invoked, that original location
> needs to be available somehow.

That would be one option. Another is to do what the proposed patch does, and what git itself does: Change the relative path into an absolute one. This requires remote-$backend to be able to modify the opaque token supplied by the user.

Yet another would be to be more strict in remote-$backend as to which opaque tokens to accept: When it contains a relative path, simply always refuse to work, even if the PWD happens to be set the right way. Of course this would be quite undesirable from a user's perspective.


> 
> Would a new helper protocol message be necessary, so that the
> backend can rewrite the $opaqueToken at "clone" time and tell the
> helper what to store as URL instead of the original?  I do not think
> that is much different from remote-$backend updating the value of the
> remote.origin.URL using "git config".
> 
> An alternative approach may be for somebody (either the "git clone"
> or the remote-$backend) to store a "base directory" when "git clone"
> was invoked in remote.origin.dirAtCloneTime variable, so that the
> next time remote-$backend runs, it can read that directory and
> interpret the $opaqueToken as a relative path to that directory if
> it wants to.  That way, nobody needs to rewrite $opaqueToken.

As I said above, this would be an option. However, I would prefer rewriting the $opaqueToken, as that would be closer to what git does for "native" tokens passed to "git clone" Specifically, I am talking about get_repo_path() in builtin/clone.c which is called by cmd_clone. What this does is in my eyes essentially the equivalent of what the patch discussed here is doing.

Anyway, at the end of the day, I mainly care about relative paths working, somehow :-). But I think it would be important to make the issue easy to resolve for all remote-$backend authors, as many of them are affected (see below).

> 
> How do other remote helpers solve this, I have to wonder, though.
> By not allowing relative paths to a directory?

So far, all I look at do not deal with this at all. Any attempts to deal with it should be pretty easy to recognize: The remote-$backend would have to store something into the git config, or else, verify the opaque token and refuse to work with it under certain conditions (e.g. when it contains a relative path). But they don't. E.g. git-remote-testgit has the exact same problem. Doing

   git init repo && cd repo && echo a > a && git add a && git ci -m a a
   git clone testgit::repo clone
   cd clone

results in a .git/config file containing

[remote "origin"]
	url = testgit::repo
	fetch = +refs/heads/*:refs/remotes/origin/*

Trying to do a "git push" from within the clone then gives this:

fatal: 'repo/.git' does not appear to be a git repository
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.
Traceback (most recent call last):
  File "/usr/local/libexec/git-core/git-remote-testgit", line 272, in <module>
    sys.exit(main(sys.argv))
  File "/usr/local/libexec/git-core/git-remote-testgit", line 261, in main
    repo = get_repo(alias, url)
  File "/usr/local/libexec/git-core/git-remote-testgit", line 39, in get_repo
    repo.get_revs()
  File "/usr/local/lib/python2.7/site-packages/git_remote_helpers/git/repo.py", line 59, in get_revs
    check_call(args, stdout=ofile)
  File "/usr/local/lib/python2.7/site-packages/git_remote_helpers/util.py", line 174, in check_call
    raise CalledProcessError(retcode, cmd)
subprocess.CalledProcessError: Command '['git', 'ls-remote', 'repo/.git']' returned non-zero exit status 128




Cheers,
Max