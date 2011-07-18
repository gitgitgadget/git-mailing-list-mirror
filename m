From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 13/17] revert: Introduce a layer of indirection over pick_commits
Date: Tue, 19 Jul 2011 02:54:23 +0530
Message-ID: <CALkWK0nYMuDeoGuvGWtmcs6Odoo0g7B_CkY63MBo38UvOHyX8g@mail.gmail.com>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
 <1310396048-24925-14-git-send-email-artagnon@gmail.com> <20110712200324.GD14909@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 18 23:24:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QivJ4-000133-5W
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 23:24:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421Ab1GRVYp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jul 2011 17:24:45 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:33506 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751199Ab1GRVYo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2011 17:24:44 -0400
Received: by wwe5 with SMTP id 5so3568537wwe.1
        for <git@vger.kernel.org>; Mon, 18 Jul 2011 14:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=S+BLAgExSaEUtIxra130AsxkxmMMg9Ie0+eSLCm9V5Y=;
        b=cQpOtugmbLxr/TjyF1FlGjLqVNjAPN5xu843lK73Qn8MlEdmNW0vK5/fL56ReiwZd7
         EaO0aJpovW1xymAG9z89Z0w0X0EJLWvUEk7HDX/bNxltibpSlemyxTQKG5p4ElP5Zt4G
         Z3rst8sMR0FIpdaVHaFGtOekiHooH9DdoYfRU=
Received: by 10.216.155.134 with SMTP id j6mr6172030wek.81.1311024283166; Mon,
 18 Jul 2011 14:24:43 -0700 (PDT)
Received: by 10.216.234.143 with HTTP; Mon, 18 Jul 2011 14:24:23 -0700 (PDT)
In-Reply-To: <20110712200324.GD14909@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177411>

Hi,

New commit message.  The "--reset" part might jump out, but it's a
result of the recent rebasing.

revert: Make pick_commits functionally act on a commit list

Apart from its central objective of calling into the picking
mechanism, pick_commits creates a sequencer directory, prepares a todo
list, and even acts upon the "--reset" subcommand.  This makes for a
bad API since the central worry of callers is to figure out whether or
not any conflicts were encountered during the cherry picking.  The
current API is like:

if (pick_commits(opts) < 0)
   print "Something failed, we're not sure what"

So, change pick_commits so that it's only responsible for picking
commits in a loop and reporting any errors, leaving the rest to a new
function called pick_revisions.  Consequently, the API of pick_commits
becomes much clearer:

act_on_subcommand(opts->subcommand);
todo_list = prepare_todo_list();
if (pick_commits(todo_list, opts) < 0)
   print "Error encountered while picking commits"

Now, callers can easily call-in to the cherry-picking machinery by
constructing an arbitrary todo list along with some options.

-- Ram
