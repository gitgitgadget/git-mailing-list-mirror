From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH v4 4/4] notes: teach git-notes about notes.<ref>.merge option
Date: Wed, 12 Aug 2015 23:46:43 +0200
Message-ID: <CALKQrgf2hdvNExVbvnP5sVUM4sEh7thj9HLw93LbYWSStNjeYg@mail.gmail.com>
References: <1439326641-9447-1-git-send-email-jacob.e.keller@intel.com>
	<1439326641-9447-5-git-send-email-jacob.e.keller@intel.com>
	<CALKQrgeDuRkXm2LzDOuZDZLOBRXjLmmRvhtXfXScWfLKX+9t=g@mail.gmail.com>
	<xmqqy4hhmedb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Git mailing list <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 23:46:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPdrN-0005AF-3a
	for gcvg-git-2@plane.gmane.org; Wed, 12 Aug 2015 23:46:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751829AbbHLVqw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2015 17:46:52 -0400
Received: from locusts.copyleft.no ([188.94.218.116]:59946 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751808AbbHLVqw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2015 17:46:52 -0400
Received: from mail-yk0-f180.google.com ([209.85.160.180])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1ZPdrF-000Lgj-7g
	for git@vger.kernel.org; Wed, 12 Aug 2015 23:46:49 +0200
Received: by ykaz130 with SMTP id z130so26139900yka.0
        for <git@vger.kernel.org>; Wed, 12 Aug 2015 14:46:43 -0700 (PDT)
X-Received: by 10.170.114.78 with SMTP id g75mr36524135ykb.94.1439416003121;
 Wed, 12 Aug 2015 14:46:43 -0700 (PDT)
Received: by 10.37.201.134 with HTTP; Wed, 12 Aug 2015 14:46:43 -0700 (PDT)
In-Reply-To: <xmqqy4hhmedb.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275813>

On Wed, Aug 12, 2015 at 4:26 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Johan Herland <johan@herland.net> writes:
>> I know that we don't yet have a "proper" place to put remote notes refs,
>> but the <ref> in notes.<ref>.merge _must_ be a "local" notes ref (you even
>> use the <localref> notation in the documentation below). Thus, I believe
>> we can presume that the local notes ref must live under refs/notes/*,
>> and hence drop the "refs/notes/" prefix from the config key (just like
>> branch.<name>.* can presume that <name> lives under refs/heads/*).
>
> I am OK going in that direction, as long as we promise that "notes
> merge" will forever refuse to work on --notes=$ref where $ref does
> not begin with refs/notes/.

If we don't already refuse to merge into a ref outside refs/notes, then
I would consider that a bug to be fixed, and not some corner use case that
we must preserve for all future.

After all, we do already have a test in t3308 named 'fail to merge into
various non-notes refs', where one of the non-notes ref being tested are:

  test_must_fail git -c "core.notesRef=refs/heads/master" notes merge x

>> Except that this patch in its current form will occupy the .merge config
>> key...
>>
>> Can you rename to notes.<name>.mergestrategy instead?
>
> This is an excellent suggestion.
>
>> Or even better, take inspiration from branch.<name>.mergeoptions,
>
> Please don't.
>
> That is one of the design mistakes that was copied from another
> design mistake (remotes.*.tagopt).  I'd want to see us not to repeat
> these design mistakes.
>
> These configuration variables were made to take free-form text value
> that is split according to shell rules, primarily because it was
> expedient to implement.  Read its value into a $variable and put it
> at the end of the command line to let the shell split it.  "tagopt"
> was done a bit more carefully in that it made to react only with a
> fixed string "--no-tags", so it was hard to abuse, but "mergeoptions"
> allowed you to override something that you wouldn't want to (e.g. it
> even allowed you to feed '--message=foo').
>
> Once you start from such a broken design, it would be hard to later
> make it saner, even if you wanted to.  You have to retroactively
> forbid something that "worked" (with some definition of "working"),
> or you have to split, parse and then reject something that does not
> make sense yourself, reimplementing dequote/split rule used in the
> shell---which is especially problematic when you no longer write in
> shell scripts.
>
> So a single string value that names one of the supported strategy
> stored in notes.<name>.mergestrategy is an excellent choice.  An
> arbitrary string in notes.<name>.mergeoptions is to be avoided.

Understood. And agreed.

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
