From: "Neal Kreitzinger" <neal@rsss.com>
Subject: Re: scan entire repo for changes to file
Date: Wed, 17 Nov 2010 18:47:10 -0600
Message-ID: <ic1t5i$9hs$1@dough.gmane.org>
References: <ibi59v$pjg$1@dough.gmane.org> <AANLkTi=uKhrvAS6ApnmCZnfbFboYU77rNcKDpaSBn1id@mail.gmail.com> <20101112014434.GA10679@burratino> <7vk4kdi2h4.fsf@alter.siamese.dyndns.org> <20101116182043.GA14552@burratino>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 18 01:49:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIsgd-00013O-SS
	for gcvg-git-2@lo.gmane.org; Thu, 18 Nov 2010 01:49:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753301Ab0KRAtG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Nov 2010 19:49:06 -0500
Received: from lo.gmane.org ([80.91.229.12]:47310 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752114Ab0KRAtF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Nov 2010 19:49:05 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PIsgQ-0000ze-7E
	for git@vger.kernel.org; Thu, 18 Nov 2010 01:49:02 +0100
Received: from 67.63.162.200 ([67.63.162.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 18 Nov 2010 01:49:02 +0100
Received: from neal by 67.63.162.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 18 Nov 2010 01:49:02 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 67.63.162.200
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-RFC2646: Format=Flowed; Original
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5931
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161641>


"Jonathan Nieder" <jrnieder@gmail.com> wrote in message 
news:20101116182043.GA14552@burratino...
> Junio C Hamano wrote:
>> Jonathan Nieder <jrnieder@gmail.com> writes:
>>> Martin von Zweigbergk wrote:
>>>> On Thu, Nov 11, 2010 at 8:28 PM, Neal Kreitzinger <neal@rsss.com> 
>>>> wrote:
>
>>>>> Is there a way to scan my entire repo (many unmerged branches) for any
>>>>> changes to a file?
>>>>> e.g.
>>>>> $ git log * -- somepath/myblob
>>>>> would return all commits in the repo that changed myblob.
>>>>
>>>> Might replacing '*' by '--all' give you what are looking for?
>>>
>>> Probably with --full-history if you want to know what happened on
>>> historic branches, too.
>>
>> You would need to clarify what you mean by "historic branches" here.
>
> Yes, quite right.  I meant failed experiments of a certain kind.
>
> The "git log -- path" facility can be used to learn the nature and
> origin of a collection of files.
>
> $ git log --graph --oneline -- block-sha1/
> * 078e9bc msvc: Select the "fast" definition of the {get,put}_be32() 
> macros
> [...]
> * d7c208a Add new optimized C 'block-sha1' routines
>
> The result is a list of commits that explains the current state of
> that file, without commits irrelevant to that purpose.
>
> What happens to merges?  Consider a history like this (history flowing
> left to right):
>
> A --- B --- C --- D --- E --- F --- G ---- M --- H
>              \                            /
>               I ...                  ... J
>
> There is a main line and a side branch.  On the mainline, the selected
> files have been getting better and better.  The side branch does not
> touch those files.  Then the side branch would irrelevant to the
> history of those files.
>
> To flesh out this idea, git history simplification.  When walking
> through history, if a merge is encountered (M) and one of the parents
> already matches the resulting state (G), then git will follow that
> parent and ignore the others.  If no parent matches the resulting
> state, git follows all parents.  So we get a simpler history that
> should still adequately explain the result.
>
> Consider another scenario, though:
>
> A --- B --- C --- D --- E --- F --- G ---- M' --- H'
>              \                            /
>               I' ...                ... J'
>
> There is a mainline and a side branch.  On the mainline, the selected
> files have been getting better and better.  On the side branch, there
> was an abortive experiment; some changes were made to the selected
> files there, but none of these changes survived as far as the merge M'.
>
> The side branch is _still_ irrelevant to the purpose of explaining the
> current state of those files.  Git will notice that (G matches M') and
> ignore the side branch.  But if your goal is not to explain the
> current state but to delve into the history of all thoughts this
> project remembers on a subject, such history simplification would not
> be appropriate and you should be using the --full-history option.
>
> The History Simplification section of git-log(1) has details.
>
> Caveat: the list of commits selected with --full-history --dense do
> not convey a coherent history.  M' is uninteresting but some of the
> commits on the I' ... J' track are; how do we stitch the interesting
> commits together?  So history visualization tools cop out and show
> all merges when --full-history is enabled.  (Put another way,
> --parents --full-history implies --no-dense.)
>
> Hope that helps.

Thank you for the explanations.  I needed to use --full-history in addition 
to --all this time because I was querying our 'QA' repo.  Our projects push 
their commits up to the QA repo and then the testers pull down from the QA 
repo a commit they want to test into a test repo that points to its own set 
of data/DB files.  Our commits contain the binaries along with the source. 
The test repos are sparse checkouts of binaries only.  As projects do 
various interactive rebases and deliver to QA without necessarily rebasing 
on master branch's HEAD and while master branch is also advancing and being 
tested, the QA repo acquires many lines of development.  These repos in 
question are for a new system so we don't have anything in true production 
yet and therefore our master branch is tested in-house rather than by 
end-users at this point.  (For our productional system the master branch is 
stable, but not for the new system I'm talking about in this context.) 
Using --all --full-history, I can interrogate everything being tested by 
querying the QA repo.  In this case, I checked to see what the impact of a 
newfound bug was on current testing by checking if any projects' QA 
deliveries had the buggy modules in any of their changesets.  Of course, I 
found that some projects had modified these modules so I was then able to 
assess the impact and devise the proper remediation.

This is my first newsgroup and I'm learning as I go so I'm not sure if I'm 
doing it right.  Jonathan, did this reply automatically show up in your 
email in addition to showing up on the newsgroup?

v/r,
Neal 
