Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130BE4184F
	for <git@vger.kernel.org>; Fri, 15 Dec 2023 16:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="F0wtjGla"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id BC5E125203;
	Fri, 15 Dec 2023 11:30:42 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=EC2eCH9yvjwzm7+4eR2UTBB1XhJRe0F/xR7y8L
	xcClU=; b=F0wtjGlad+u0OW5rBtYkEHjJXffDIq7aywDPDYTtmJGtGRifwfdyJV
	f128xk6lia3QUONWWpEIa0MXT489Lv86hpRQRnfKnI0Sq0/dEC1YSSay4lJLeITF
	QWzns0+azrgHVH+eDn02X4/Rav9jJo0HiQ96/NuK3x9olJtjPcg8E=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id B42E925202;
	Fri, 15 Dec 2023 11:30:42 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5D1B125200;
	Fri, 15 Dec 2023 11:30:39 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Sean Allred <allred.sean@gmail.com>
Cc: git <git@vger.kernel.org>
Subject: Re: What's the recommendation for forgetting all rerere's records?
In-Reply-To: <m0sf43abw7.fsf@epic96565.epic.com> (Sean Allred's message of
	"Fri, 15 Dec 2023 06:21:36 -0600")
References: <m0y1e7kkft.fsf@epic96565.epic.com> <xmqqcyvgz3ih.fsf@gitster.g>
	<m0sf43abw7.fsf@epic96565.epic.com>
Date: Fri, 15 Dec 2023 08:30:37 -0800
Message-ID: <xmqqa5qbmnrm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 486ABF0E-9B67-11EE-AE1A-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Sean Allred <allred.sean@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>> Sean Allred <allred.sean@gmail.com> writes:
>>> When outside the context of a conflict (no rebase/merge in progress),
>>> what's the intended workflow to clear out the contents of
>>> $GIT_DIR/rr-cache?
>>
>> You could "rm -fr .git/rr-cache/??*" if you want.
>
> Here's my reasoning for not wanting that:
>
>>> I'm wary of recommending `rm -rf "$(git rev-parse --git-dir)/rr-cache"`
>>> -- it's hard to describe this as anything but hacky when the rest of the
>>> experience is handled in porcelain.

It is meant to be ugly ;-); the reason why the Porcelain does not
offer bulk erasure is because we want to strongly discourage it.

>> The "intended" workflow is there will no need to "clear out" at all;
>> you may notice mistaken resolution, and you will remove it when you
>> notice one, but the bulk of the remaining database entries ought to
>> be still correct.
>
> When we noticed mistaken resolutions, rerere had already applied the
> recorded resolution and there was no apparent way to return to the
> conflicted state.

The simplest is to go back to the original state before the merge
and then redo the operation without rerere enabled.

    $ git reset --hard
    $ git -c rerere.enabled=no merge <whatever arguments you used>

And you can redo the merge manually.

But more generally, after you incorrectly resolved a merge conflict,
whether you fumbled with your editor yourself or you let rerere kick
in to reuse your recorded resolution that you made in the past that
was faulty, before or after you run "git add" to tell the resolution
to the index, you should be able to do

    $ git checkout --merge <pathspec>

to tell Git to "unresolve" such paths.  Here is the relevant
paragraph from the "git checkout --help":

    When checking out paths from the index, this option lets you recreate the
    conflicted merge in the specified paths. This option cannot be used when
    checking out paths from a tree-ish.

The below is what I just did to demonstrate.  You can try the same
if you have our source code.  The first attempt will likely to
conflict because you do not have the rerere record, but you can
resolve the conflict in builtin/mv.c the way I did (shown by first
"git diff" in the sample transcript), and run "git rerere" (or just
"git commit -a" should also work) to record the resolution, and then
"git reset --hard" to obtain a sample rerere record you can use to
practice.

    # Just a sample merge I know will have a conflict
    $ SAMPLE=a59dbae0b3bd; # v2.43.0-rc0~126

    # Go to its parent and retry the merge with its second parent
    $ git checkout --detach $SAMPLE^1
    $ git merge $SAMPLE^2
    Auto-merging builtin/mv.c
    CONFLICT (content): Merge conflict in builtin/mv.c
    Resolved 'builtin/mv.c' using previous resolution.
    Automatic merge failed; fix conflicts and then commit the result.

    # We have conflict, and rerere kicked in.  Because I do not have
    # rerere.autoupdate configuration set, I can as "ls-files -u"
    # which paths are conflicting, but that is unnecessary (we
    # can see the path with conflict with the CONFLICT label above).
    $ git ls-files -u
    100644 665bd274485f6c76403e9230539e2650073a47f3 1	builtin/mv.c
    100644 05e7156034e04d637990cabf105f7fa967b0f2aa 2	builtin/mv.c
    100644 80fc7a3c7029603a0fcaf9d15d8432ed799b4909 3	builtin/mv.c

    # This is the resolution "rerere" gave me, which is what I did
    # back in August this year.  If you are following this example,
    # you'll first have to edit builtin/mv.c to hand resolve,
    # register the resolution to "rerere" database, and then run
    # "git reset --hard" to go back to the state before you did the
    # "git merge $SAMPLE^2" step to repeat.
    $ git diff
    diff --cc builtin/mv.c
    index 05e7156034,80fc7a3c70..0000000000
    --- i/builtin/mv.c
    +++ w/builtin/mv.c
    @@@ -304,8 -303,8 +304,8 @@@ int cmd_mv(int argc, const char **argv
                            goto act_on_entry;
                    }
                    if (S_ISDIR(st.st_mode)
     -		    && lstat(dst, &st) == 0) {
     +		    && lstat(dst, &dest_st) == 0) {
    - 			bad = _("cannot move directory over file");
    + 			bad = _("destination already exists");
                            goto act_on_entry;
                    }

    # Now the fun command you seem to have missed.  You MUST give
    # "git checkout --merge" a pathspec.  I do not encourage it but
    # using "." to say "unresolve everything under the sun" should
    # also work.
    $ git checkout --merge builtin/mv.c
    Recreated 1 merge conflict

    # Let's check the result.  We have recreated the conflicted
    # state in the working tree.
    $ git diff
    diff --cc builtin/mv.c
    index 05e7156034,80fc7a3c70..0000000000
    --- i/builtin/mv.c
    +++ w/builtin/mv.c
    @@@ -304,8 -303,8 +304,16 @@@ int cmd_mv(int argc, const char **argv
                            goto act_on_entry;
                    }
                    if (S_ISDIR(st.st_mode)
    ++<<<<<<< ours
     +		    && lstat(dst, &dest_st) == 0) {
     +			bad = _("cannot move directory over file");
    ++||||||| base
    ++		    && lstat(dst, &st) == 0) {
    ++			bad = _("cannot move directory over file");
    ++=======
    + 		    && lstat(dst, &st) == 0) {
    + 			bad = _("destination already exists");
    ++>>>>>>> theirs
                            goto act_on_entry;
                    }

    # You should then be able to correct the resolution with your
    # editor.
    $ edit builtin/mv.c

    # If this is one-time fix (you are happy with the original
    # resolution and wanted to deviate from it only once this time),
    # there is nothing else need to be done.  If you want to record
    # this as a new resolution, you'd get rid of the old one and
    # record this one.
    $ git rerere forget builtin/mv.c
    $ git rerere



