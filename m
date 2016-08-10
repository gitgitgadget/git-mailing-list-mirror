Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E1BC1FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 22:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932628AbcHJWJY (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 18:09:24 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:42568 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932392AbcHJWJW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 18:09:22 -0400
Received: from [IPv6:2607:fb90:48c9:c81b:f385:689a:55b6:6849] (unknown [IPv6:2607:fb90:48c9:c81b:f385:689a:55b6:6849])
	(Authenticated sender: josh@joshtriplett.org)
	by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 3178517209B;
	Thu, 11 Aug 2016 00:08:02 +0200 (CEST)
User-Agent: K-9 Mail for Android
In-Reply-To: <20160810093731.GA3404@salo>
References: <20160729064055.GB25331@x> <20160803191202.GA22881@salo> <20160804224058.po43kl7w26ockfie@x> <20160810093731.GA3404@salo>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [ANNOUNCE] git-series: track changes to a patch series over time
From:	Josh Triplett <josh@joshtriplett.org>
Date:	Wed, 10 Aug 2016 12:07:26 -1000
To:	Richard Ipsum <richard.ipsum@codethink.co.uk>
CC:	git@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <13509A14-16CB-476C-B983-7001F3D0DA61@joshtriplett.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On August 9, 2016 11:37:31 PM HST, Richard Ipsum <richard.ipsum@codethink.co.uk> wrote:
>On Thu, Aug 04, 2016 at 12:40:58PM -1000, Josh Triplett wrote:
>> On Wed, Aug 03, 2016 at 08:12:02PM +0100, Richard Ipsum wrote:
>> > On Thu, Jul 28, 2016 at 11:40:55PM -0700, Josh Triplett wrote:
>> > > I'd welcome any feedback, whether on the interface and workflow,
>the
>> > > internals and collaboration, ideas on presenting diffs of patch
>series,
>> > > or anything else.
>> > 
>> > One other nice thing I've noticed about this tool is the
>> > way series behave like regular git branches: I specify the name
>> > of the series and from then on all other commands act on that
>> > series until told otherwise.
>> 
>> Thanks; I spent a while thinking about that part of the workflow.  I
>> save the current series as a symbolic ref SHEAD, and everything
>operates
>> on SHEAD.  (I should probably add support for running things like
>"git
>> series log" or "git series format" on a different series, because
>right
>> now "until told otherwise" doesn't include a way to tell it
>otherwise.)
>
>Apologies for this delayed response,
>I needed time to gather my thoughts,
>and also to fix the perl libgit2 binding to allow me to use
>your symbolic ref suggestion. :p

Yeah, during git-series development I ended up doing some work on both libgit2 and git2-rs. :)

>Though it turns out that libgit2 doesn't currently allow
>me to write arbitrary data to a symbolic ref as git-symbolic-ref(1)
>will,
>so this still needs to be fixed somehow.

What arbitrary data do you need to write?

Also, note that you want to put your symbolic ref in refs/, not directly in .git, so that git takes it into account for object reachability.

>> > git-appraise looks as though it might also have this behaviour.
>> > I think it's a nice way to do it, since you don't generally
>> > perform more than one review simultaneously. So I may well
>> > use this idea in git-candidate if it's okay. :)
>> 
>> By all means.  For a review tool like git-candidate, it seems like
>you'd
>> want even more contextual information, to make it easier to specify
>> things like "comment on file F line L".  For instance, what if you
>> spawned the diff to review in an editor, with plenty of extra context
>> and a file extension that'll cause most editors to recognize it as a
>> patch (and specifically a git-candidate patch to allow specialized
>> editor modes), and told people to add their comments after the line
>they
>> applied to?  When the editor exits successfully, you can scan the
>file,
>> detect the added lines, and save those as comments.  You could figure
>> out the appropriate line by looking for the diff hunk headers and
>> counting line numbers.
>
>I really like this idea, the current interface for commenting is a
>little
>tedious I find.
>
>> 
>> If you use a format-patch diff that includes the headers and commit
>> message, you could also support commenting on those in the same way.
>> Does the notedb format support commenting on those?
>
>Comments in notedb are just a git note keyed on the sha of the
>commit being commented on, I'm not certain what advantage a
>format-patch
>diff provides in this case?

I meant for opening in an editor to write email-reply-style comments. The review tool and review storage format should allow commenting on commit messages, not just diffs.

>I've been closely following the 'patch submission process' thread,
>and given the discussion there I'm having doubts over the value
>of comments in git-candidate vs the mailing list. It seems to me that
>git-candidate has many of the disadvantages of Github/Gitlab when it
>comes to comments, for example, there is no threading.

That's not inherent, though. You could allow commenting on a comment easily enough. (Of course, at some point you've recreated email-style in-reply-to headers...)

>Also the system would be less open than the mailing list, since,
>as it stands currently you would require push access to the repository
>to comment on anything.

You'd need a federation mechanism.

>It may be worth reflecting that one reason some organisations
>have switched away from mailing list reviews to Github/Gitlab is that
>they provide patch tracking, where the mailing list provides none,
>so patches there can be 'lost'. So instead of trying to reimplement
>an entire Gerrit/Github/Gitlab ui on the commandline, I wonder whether
>it would be sufficient to add the minimum functionality necessary
>to provide git with native patch tracking, and leave comments for the
>mailing list. Ofcourse this is exactly what git-series seems to do,
>so in some sense I may be advocating dropping my own work in favour of
>improving git-series.

I think the two serve different (though related) functions. I'd love to be able to use a text editor and command-line tool to produce and submit comments to systems like Gerrit or GitHub.

>On the other hand, relying on the mailing list means that some of the
>history of a series is left outside of the repository which is
>anathema to the goal of git based/stored review, not least because
>mail archives are centralised.
>(which can obviously be problematic (as we've seen recently with
>gmane))

Agreed. You can always choose to *intentionally* discard history, or store it elsewhere, but having it in the repository allows you to make that decision with all the data really available (and easily backed up).

>Maybe there's a better solution to this problem than git-candidate
>then,
>maybe we can just invent some wonderful new subcommand that fetches
>a mailing list archive into a git repo, for those that want that,
>I don't know.

public-inbox seems to address that use case. I'd love to see a public-inbox version of LKML, with full history. I don't think that fully solves the review storage and interchange problem, but it seems like an *excellent* solution for email archiving, and for distribution of archives.

>Out of interest, did you have any thoughts on Notedb itself with
>respect
>to its suitability for git-series?

Seems like a potentially reasonable format for storing reviews. I think the two could work well together, with git-series storing all the historical versions of a series, and then a notedb could reference those commits.

I've given some thought to using git-series as a server-side storage format for something like a pull request. I think it might make sense for a tool like Gerrit or GitLab to allow pushing and pulling series branches (that must fast-forward) to a special ref (like Gerrit's refs/for/master).

