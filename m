From: Pierre Habouzit <madcoder@debian.org>
Subject: git send-email improvements
Date: Fri, 31 Oct 2008 11:57:09 +0100
Message-ID: <1225450632-7230-1-git-send-email-madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 31 11:59:02 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvriF-0001ag-2t
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 11:58:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750881AbYJaK5X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 06:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750867AbYJaK5X
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 06:57:23 -0400
Received: from pan.madism.org ([88.191.52.104]:53955 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750747AbYJaK5Q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 06:57:16 -0400
Received: from madism.org (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 862873B420
	for <git@vger.kernel.org>; Fri, 31 Oct 2008 11:57:14 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id AADD65EE240; Fri, 31 Oct 2008 11:57:12 +0100 (CET)
X-Mailer: git-send-email 1.6.0.3.759.g40a2.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99572>

The teaser
==========

This series has been sent using:
  git send-email --to git@vger.kernel.org --compose --annotate HEAD~3..


The series
==========

Here is a patch series to improve git send-email following our
discussions at GitTogether'08, despite my hate for perl.

The first patch is a minor nitpick, because leaking fd's sucks.

The second patch allow git-send-email to receive revision lists as
arguments. This doesn't allow complex arguments combinations as it
proces the revision lists one by one (IOW ^$sha1 $sha2 won't work as
expected _at all_) but this shouldn't be a problem since this command is
primarily used for interactive users. People wanting to use
git-send-email with complex revision lists through scripts MUST
git-format-patch first into a safe temporary directory and use
git-send-email on this afterwards.

The last patch adds the possibility to review patches into an editor
before sending them, which allow you (thanks to patch 2) to serialize,
review, annotate, and send patches in one command.


Further discussion
==================

I think one could make git send-email better doing this:

(1) make --compose and --annotate default, do not asking for a Subject
    if it's missing, neither should we ask for the in-reply-to if it's
    missing.

    Then spawn the editor with a first empty file that contains rougly a
    template looking like this:

        ----8<----
        GIT: Purge this buffer from any content if you don't want a series summary
        GIT:
        GIT: Lines beginning in "GIT: " will be removed.
        GIT: Consider including an overall diffstat or table of contents
        GIT: for the patch you are writing.
        GIT:
        GIT: Please fill a Subject if missing
        GIT: Leave the In-Reply-To field empty if not applicable.
        Subject:
        In-Reply-To:
        --> <we may want to add some more headers here: To/Cc/Bcc/...>

        GIT: put the content of the mail below this line


        GIT: [PATCH 1/10] ....  \
        GIT: [PATCH 2/10] ....   | this would contain all the Subject's
        [...]                    | from the commits that are beeing sent
        GIT: [PATCH 8/10] ....   | as a conveniency for people not
        GIT: [PATCH 9/10] ....   | having to cut&paste them
        GIT: [PATCH 10/10] .... /
        ---->8----

    I suggest we don't enable --compose when the series is reduced to
    one patch, as the usual way is to comment inline. This is probably
    arguable.

(2) Introduce a --batch option that basically:
    * turns --compose and --annotate off
    * turns any interactive feature off
    * complain (and fail) if it misses any information that is usually
      asked interactively

What do you think ?
