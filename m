From: Marc Weber <marco-oweber@gmx.de>
Subject: tg-update rewrite proposal
Date: Fri, 24 Apr 2009 01:11:24 +0200
Message-ID: <20090423231124.GC17647@gmx.de>
References: <20090420205023.GB2005@gmx.de> <20090421090413.GA5718@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: u.kleine-koenig@pengutronix.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 24 01:13:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lx86S-0006Ir-Ac
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 01:13:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754978AbZDWXL2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2009 19:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752409AbZDWXL2
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 19:11:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:38746 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751291AbZDWXL1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2009 19:11:27 -0400
Received: (qmail invoked by alias); 23 Apr 2009 23:11:24 -0000
Received: from pD9E0BB90.dip.t-dialin.net (EHLO mail.gmx.net) [217.224.187.144]
  by mail.gmx.net (mp011) with SMTP; 24 Apr 2009 01:11:24 +0200
X-Authenticated: #9006135
X-Provags-ID: V01U2FsdGVkX1/so2ARK1/szxNL7ZB8KH8XGWJquJSDcf2DdyNBHC
	NnwdhSC5YgiI+c
Received: by mail.gmx.net (sSMTP sendmail emulation); Fri, 24 Apr 2009 01:11:24 +0200
Mail-Followup-To: Marc Weber <marco-oweber@gmx.de>, git@vger.kernel.org,
	u.kleine-koenig@pengutronix.de
Content-Disposition: inline
In-Reply-To: <20090421090413.GA5718@pengutronix.de>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117396>

Hi Uwe,

I came up with this proposal for a rewrite for tg-update.sh now:
I hope this fits your ideas about tg update as well..

Note that second "for each dependency [1]" below allowing handling updates
against multiple remote repos.

I hope that its easy to understand this short documentation draft.

Sincerly
Marc Weber

# documentation:

# Uwe Klein Koenig suggests keeping updating with remote branches
# which corresponds to "git pull" in default git separate from
# updating branches with deps (normal branhces and/or tg branches)
# 
# Because of [3] my implementation of tg update starts at the bottom going up
# first updating with remotes then with deps by default.
# However you can choose to only update with remotes
# or with deps only using --remotes-only or --local-only
# I hope this satisfies everyone.

# Providing a subshellless update experience can only be done by saving
# some state the way git-rebase does. STATE_DIR will be used to save this state
#
# What's saved in STATE_DIR ?
#
# $STATE_DIR/$BRANCHES_VISITING_ORDER is a list of dependency names [1] which is generated
# by traversing the dependency tree of branches form bottom up
#
#  Example:
#     A    B  C   D
#      \  /    \ /
#       t/1   t/2
#         \   /
#       t/working
#
#  will result in
#
#     A
#     B
#     t/1
#     C
#     D
#     t/2
#     t/working

# Then the first line is picked and the specified branch is updated.
# updating is done in this order [3]:
#
#   first:
#   if not --local-only
#      foreach remote location:
#        - merge base with remote tg branch (thereby also including the remote base)
#          update the base ref [2]
#        - update tg [*]
#    
#   then:
#   if not --remote-only
#      for each dependency [1]
#         - merge base with dep [2]
#      - update tg [*]
#    
#     [*]: merge new base with topgit branch updating the topgit ref.
#          After this step the base is always contained in the current branch
#
# Similar to $STATE_DIR/BRANCHES_VISITING_ORDER a file $STATE_DIR/$BRANCH_UPDATE_TASKS is
# created containing the subtasks of a branch update.
# 
# Example file with additional comment lines, two remote locations:
#
#   # first:
#   merge_base_with: $REMOTE_HASH
#   update_tg
#   merge_base_with: $REMOTE_HASH2
#   update_tg
#
#   # then:
#   merge_base_with: $DEP1_HASH
#   update_tg
#   merge_base_with: $DEP2_HASH
#   update_tg
#   merge_base_with: $DEP3_HASH
#   update_tg



# So the overall implementation is easy and looks like this:
#
# if !exists $STATE_DIR/BRANCHES_VISITING_ORDER
#   then create file, goto else
#   else pop_or_continue
#
# pop_or_continue:
# if !exists $STATE_DIR/$BRANCH_UPDATE_TASKS
#   then create file, goto else
#   else pop_or_continue_subtask
#
#  pop_or_continue_subtask:
#  ...

# [1] note for users who knew the old code: not including remotes
#
# [2] This means creating a commit to the topic branch changing the .topbase file only
#
# [3] I think the following statements make sense:
#     *) You want to update against remote first. Or you want to have a way to do so.
#        Why? The remote may already have done some of the dirty merge work for you.
#        If you resolving the same conflicts first by updating with deps and then merge
#        with remote -> hell!
#     *) You don't want to run tg update multiple times. Thus the update strategy has
#        to start at the bottom and go up to the current branch



# state dir and filenames:
STATE_DIR=.git/tg-update-in-progress 
BRANCHES_VISITING_ORDER=branches-visiting-order
BRANCH_UPDATE_TASKS=branch-update-tasks

## Parse options

if [ -n "$1" ]; then
        echo "Usage: tg [--local-only] [--remote-only] update" >&2
        exit 1
fi
