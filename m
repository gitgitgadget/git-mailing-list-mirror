From: "Tom Clarke" <tom@u2i.com>
Subject: Re: How to re-use setups in multiple tests?
Date: Mon, 1 Oct 2007 14:16:47 +0200
Message-ID: <550f9510710010516s305c843br53da294f65318862@mail.gmail.com>
References: <550f9510710010327l3e729ff1tbbb9b6c674c1cb11@mail.gmail.com>
	 <Pine.LNX.4.64.0710011243230.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 01 14:17:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcKD6-00057l-3H
	for gcvg-git-2@gmane.org; Mon, 01 Oct 2007 14:17:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751762AbXJAMQu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2007 08:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751447AbXJAMQu
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Oct 2007 08:16:50 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:64189 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751657AbXJAMQt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2007 08:16:49 -0400
Received: by py-out-1112.google.com with SMTP id u77so6989018pyb
        for <git@vger.kernel.org>; Mon, 01 Oct 2007 05:16:48 -0700 (PDT)
Received: by 10.35.17.8 with SMTP id u8mr7727955pyi.1191241008034;
        Mon, 01 Oct 2007 05:16:48 -0700 (PDT)
Received: by 10.35.86.2 with HTTP; Mon, 1 Oct 2007 05:16:47 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0710011243230.28395@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59607>

In this case the first test rebases the branch created in setup (it's
testing the rebase merge strategy), the second test should do the same
thing, except check there is a warning if a --message option is
passed.

I suppose I could find the old pre-rebase head and work with that, but
that doesn't seem that clean to me.

Here's the code (non-working):

#!/bin/sh

test_description='merge-rebase backend test'

. ./test-lib.sh

test_expect_success setup '
        echo hello >a &&
        git add a &&
        test_tick && git commit -m initial &&

        git checkout -b branch &&
        echo hello >b &&
        git add b &&
        test_tick && git commit -m onbranch &&

        git checkout master &&
        echo update >a &&
        git add a &&
        test_tick && git commit -m update
'

test_expect_success 'merging using rebase does not create merge
commit' '
        git checkout branch &&
        git merge -s rebase master &&

        ( git log --pretty=oneline ) >actual &&
        (
                echo "4db7a5a013e67aa623d1fd294e8d46e89b3ace8f
onbranch"
                echo "893371811dbd13e85c098b72d1ab42bcfd24c2db update"
                echo "0e960b10429bf3f1e168ee2cc7d531ac7c622580
initial"
        ) >expected &&
        git diff -w -u expected actual
'

test_expect_success 'merging using rebase with message gives warning'
'
        #doesn't work because the branch has already been rebased and
is therefore up to date
        git checkout branch &&
        git merge -m "a message" -s rebase master 2>&1 expected &&
        (
                echo "warning: Message is not used for rebase merge
strategy"
        ) >expected &&
        git diff -w -u expected actual
'

test_done


-Tom

On 10/1/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Mon, 1 Oct 2007, Tom Clarke wrote:
>
> > I'm wondering if there's a pattern for re-using setups across several
> > tests, similar to how a setUp function is used in xUnit. The problem is
> > I need the setup to actually be re-run, for each test to start from a
> > clean slate, so using the following doesn't work as the setup is just
> > run before the first test.
>
> We typically do the clean up phase explicitely.  Or avoid it.
>
> Example: you want to do something to a branch, but the next step should
> use the original state of the branch.
>
> Solution: "git checkout -b new-branch HEAD~5"
>
> Sorry, unless you are a little less mysterious about the exact use case
> you have in mind, I cannot help more.
>
> Ciao,
> Dscho
>
>
