From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH/RFC] blame: respect "core.ignorecase"
Date: Mon, 10 Sep 2012 07:57:26 +0200
Message-ID: <CAN0XMOLpQLNk2vSxjxahxEoVxjx8wi4EnVDytEZPhVeYn7XLiw@mail.gmail.com>
References: <1347210113-27435-1-git-send-email-ralf.thielow@gmail.com>
	<7v7gs3q9rp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 10 07:57:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAx04-0006xi-SQ
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 07:57:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394Ab2IJF53 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 01:57:29 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:59811 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750718Ab2IJF51 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Sep 2012 01:57:27 -0400
Received: by weyx8 with SMTP id x8so1043865wey.19
        for <git@vger.kernel.org>; Sun, 09 Sep 2012 22:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=i8rtiSu/i8X1wGFu9skB7OfHIWKssrVZQo+dEub0jXo=;
        b=k3JyrNIFlOc+8WdRByngiGTlVEoQx66Zf5uIrI+rd4VpXyHzDB8kWMl9sdbi2h5XZH
         LwvPg32pvOXNw1ujNNxXyb1zH++PtZK0/0otqWwACh3jipp4JFH/2nweG0tCROnarDk7
         uMig9cJsxrAHsm4PJCkg2ia/x/nsxMcKkfkirokyKCK1+HtbFyVMAKAuKvXAS9TqJuZD
         xoEspXR6I+IjUVNQ4a/UuccF+RE/aqubUE7GRl17oskOtxFEgGzmwWVymd2DZ3nxrx+3
         kfVzkb5MAxkBenTwxTDyx4HtVjuXUki7ZmjyYG/TwTQLiVmuWB2eq6gDP3C/f1vFxHBN
         /7Rw==
Received: by 10.180.104.200 with SMTP id gg8mr14567897wib.14.1347256646471;
 Sun, 09 Sep 2012 22:57:26 -0700 (PDT)
Received: by 10.194.23.201 with HTTP; Sun, 9 Sep 2012 22:57:26 -0700 (PDT)
In-Reply-To: <7v7gs3q9rp.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205110>

On Sun, Sep 9, 2012 at 9:24 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Ralf Thielow <ralf.thielow@gmail.com> writes:
>
>> If "core.ignorecase" is true, "git blame" fails
>> when the given path differs to the real path in case
>> sensitivity.
>
> It is rather hard to respond to this request for comment because you
> are describing the behaviour you perceive as a problem only fuzzily
> (i.e. "fails"---what does it do?) without describing the expectation
> (i.e. what should it do instead?).
>
>> +test-path-ignorecase$X: builtin/blame.o
>
> Yuck.  If it is a helper function that deserves its own unit test
> helper executable, shouldn't it live with somewhere more appropriate
> to be shared across commands?
>
>> +const char* get_path_ignorecase(const char *path)
>> +{
>> +     struct strbuf res = STRBUF_INIT;
>> +     struct strbuf p = STRBUF_INIT;
>> +     int offset = 0;
>> +
>> +     if (!ignore_case || has_string_in_work_tree(path))
>> +             return path;
>
> If the problem you are trying to solve is that the HEAD and the
> history has Makefile but the user said "git blame MAKEFILE"
> (i.e. start traversing from the contents in the working tree), then
> has_string_in_work_tree("MAKEFILE") will return true, and this
> function will tell us to find the contents for "MAKEFILE" not
> "Makefile" in the next revision (i.e. HEAD:MAKEFILE).
>
> As you didn't describe what you perceive as the problem, I do not
> know if the above analysis matters for the case you are trying to
> fix, though.
>
> Step back a bit and write down what problem you are trying to solve,
> including what existing behaviour you should *not* alter.
>
> Suppose we have this history (time flows from bottom to top), and
> our HEAD is at commit F.  We may or may not have modifications to
> Makefile in the working tree:
>
>     F  Add Makefile again
>     E  Remove Makefile
>     D  Modify Makefile
>     C  Remove MAKEFILE, add Makefile with related or unrelated contents
>     B  Modify MAKEFILE
>     A  Add MAKEFILE
>
> What should happen to the following?
>
>     $ git blame Makefile
>     $ git blame MAKEFILE
>     $ git blame MakeFILE
>
>     $ git blame HEAD -- Makefile
>     $ git blame HEAD -- MAKEFILE
>     $ git blame HEAD -- MakeFILE
>
>     $ git blame E -- Makefile
>     $ git blame E -- MAKEFILE
>     $ git blame E -- MakeFILE
>
>     $ git blame B -- Makefile
>     $ git blame B -- MAKEFILE
>     $ git blame B -- MakeFILE
>
> Git should see the pathname that was given by the user literally for
> any of the latter 9 cases (i.e. if we are not starting from the
> contents of the working tree) regardless of ignorecase.  If the user
> tells us to blame MAKEFILE starting from B, "fixing" the path to the
> version you can read from the working tree that may be similar to
> what you have at commit F (i.e. HEAD) and turn it to a blame for
> Makefile is a wrong thing to do, no?
>
> Another potential problem with the approach your patch takes may be
> that the case insensitive filesystem you are dealing with might be
> not just case insensitive, but also be case destroying.  The user
> may say "edit Makefile && git add Makefile", the filesystem may say
> there is MAKEFILE there, and core.ignorecase is designed to handle
> this case well by treating that the user really meant Makefile and
> that it is the filesystem that is lying to us.
>
> Now that we established that the "fixing" of the path we got from
> the user, should _never_ look at the working tree.  Also, if such a
> "fixing" ever is useful, it should be done only in the first three
> cases where the user tells us to start blaming from the working
> tree.
>
> So what should happen to the first three cases?  When doing
>
>     $ git add Makefile
>     $ git add MAKEFILE
>     $ git add MakeFILE
>
> we infer the case the user really meant by attempting to match the
> path against what is recorded in the index.  If there is no matching
> entry, we use what we got from the user, but if there is a matching
> one (and core.ignorecase affects how this matching is done), we fix
> the path by using the path recorded in the index instead.  Then we
> will turn the top three cases to "git blame Makefile".
>
> That brings us back to the case where we start blaming from a commit
> (the latter 9 cases).  It might make sense to grab the path in the
> tree of the named commit that matches in the core.ignorecase sense
> to the path given by the user.  Even though commit F does not have
> MAKEFILE nor MakeFILE, we turn the path given by the user to Makefile
> because that is the only path that the user _could_ have meant in
> the context of the command (similarly, MAKEFILE for a blame starting
> at B).  When starting to blame at E that does not have Makefile or
> MAKEFILE, we would use whatever the user threw at us.
>
> I said "might make sense" for the last paragraph for a reason,
> though.  In the history A..F above, if the user is aware of the fact
> that the history _is_ case sensitive (and setting core.ignorecase is
> a signal that she does---it is an admission that the filesystem she
> happens to have her working tree is incapable of interacting with
> such a history natively and needs a bit of help from Git) and that
> some commit have Makefile and others have MAKEFILE, it will look
> inconsistent if she asked "git blame D -- MAKEFILE" and gets the
> result for "git blame D -- Makefile" instead.
>
> Having said all that, I am not sure if the "fixing" is really the
> right approach to begin with.  Contrast these two:
>
>     $ git blame MakeFILE
>     $ git blame HEAD -- MakeFILE
>
> The latter, regardless of core.ignorecase, should fail, with "No
> such path MakeFILE in HEAD".  The former is merely an extension to
> the latter, in the sense that the main traversal is exactly the same
> as the latter, but on top, local modifications are blamed to the
> working tree.
>
> If we were to do anything, I would think the most sane thing to do
> is a smaller patch to fix fake_working_tree_commit() where it calls
> lstat() and _should_ die with "Cannot lstat MakeFILE" on a sane
> filesystem.  It does not currently make sure the path exists in the
> HEAD exactly as given by the user (i.e. without core.ignorecase
> matching), and die when it is not found.
>
> And that can be done regardless of core.ignorecase.  Currently on a
> case sensitive filesystem without core.ignorecase, this will give a
> useless result:
>
>     $ git rm Nakefile || :;
>     $ git commit --allow-empty -m 'Made sure there is no Nakefile'
>     $ >Nakefile
>     $ git blame -- Nakefile
>     00000000 (Not Committed Yet 2012-09-09 12:21:42 -0700 1)
>
> and such a change to verify that the path exists in HEAD will give
> us "No such path Nakefile in HEAD" in such a case.
>
> It is a behaviour change, but I think it is a good change,
> regardless of the "What I have is Makefile, but my filesystem lies
> to us saying yes when I ask if MAKEFILE exists" issue.
>

Thanks for your long answer! I've learned a lot out of it.
Just to answer your question, you were right, the problem
I wanted to solve is the following:

echo "foo" > README && git add README && git commit -m "add README"
git config core.ignorecase false
git add README; # OK
git add readme; # 'fatal: pathspec 'readme' did not match any files' OK
git blame README; # has a result, OK
git blame readme; # 'fatal: cannot stat path 'readme': No such file or
directory' OK

git config core.ignorecase true
git add readme; # now there's no error here; OK
git blame readme; # still an error << NOK
git blame HEAD -- readme; # 'fatal: no such path readme in HEAD' << NOK

Thanks
