From: Jakub Narebski <jnareb@gmail.com>
Subject: [1.8.0] Tracking empty directories
Date: Wed, 02 Feb 2011 03:56:08 -0800 (PST)
Message-ID: <m3zkqe8xc8.fsf_-_@localhost.localdomain>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org>
	<7vwrll57ha.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 02 12:56:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkbJp-0005Z3-35
	for gcvg-git-2@lo.gmane.org; Wed, 02 Feb 2011 12:56:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753621Ab1BBL4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Feb 2011 06:56:11 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:35348 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753192Ab1BBL4L (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Feb 2011 06:56:11 -0500
Received: by fxm20 with SMTP id 20so7929861fxm.19
        for <git@vger.kernel.org>; Wed, 02 Feb 2011 03:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:subject:references
         :from:date:in-reply-to:message-id:lines:user-agent:mime-version
         :content-type;
        bh=w3rvVCUBy9QGNz157YwveMYg+kr9Tj8HNQu5aZ84V2w=;
        b=RDacHV/pVB8tgLhd0tE9kF5Zu5uZ9vB9kptt10IjHUEXgjy7Nn8gOr4Ixj9+nFMIkp
         bV5LohfPEzZCcSnIIqldO/5W9rWaJEmNVh1xXh1jAAv7Myami7fPPoKZjDdZopwrOlmm
         4Sr5iVwqa5h7T/6r3lh0N4KLZtLSEgWOOIS6I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=BiYU9IxS6Y/81bWlX3ORviVie3s/Qo6hfhMap87jhL6pC58NnvnKIqIs/z+ZYyN+qX
         xGcrUi0EltTtBtR47ZHWk2r527NxfmVEuMvXibIyqjB9qtjpBPhnDSfqNm21lwP5OD9b
         LYNztMK08vnr2vb2iSgdv5aslN9dtamyjG8BI=
Received: by 10.223.101.199 with SMTP id d7mr8577027fao.65.1296647769691;
        Wed, 02 Feb 2011 03:56:09 -0800 (PST)
Received: from localhost.localdomain (abvv233.neoplus.adsl.tpnet.pl [83.8.219.233])
        by mx.google.com with ESMTPS id n26sm8297157fam.37.2011.02.02.03.56.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 02 Feb 2011 03:56:08 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p12Btk4h006554
	for <git@vger.kernel.org>; Wed, 2 Feb 2011 12:55:56 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p12BtaSO006551;
	Wed, 2 Feb 2011 12:55:36 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vwrll57ha.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165904>

See "Tracking empty directories" subthread on git mailing list,
starting with

  http://thread.gmane.org/gmane.comp.version-control.git/165655/focus=165831

The idea is for git to be able to track empty directories without the
.keepme (or empty .gitignore) file trick.  This was one of the most
requested features is native support for tracking empty directories,
with 35.2% support (from those who answered question) in 
"Git User's Survey 2010":

  https://git.wiki.kernel.org/index.php/GitSurvey2010#17._Which_of_the_following_features_would_you_like_to_see_implemented_in_git.3F


There were some concerns about *backwards compatibility* of this
feature, see for example this email (which I would summarize here).

  http://thread.gmane.org/gmane.comp.version-control.git/165655/focus=165847

That's why it is in 1.8.0 proposals.

The problem with backward compatibility is twofold.  First and more
important is while git supports empty tree object (it has it hardcoded
for some time, as it is necessary e.g. for initial diff, or merging
unrelated branches without common ancestor), and there is no problem
with entry for empty tree in a tree object

  040000 tree 22d5826c087c4b9dcc72e2131c2cfb061403f7eb	empty

there is (supposedly) problem when checking out such tree (see email
referenced above) with an old git.

Second is that tracking empty directories would require extension to the
git index (storing trees in index, like we store submodules)... but that
is purely local matter.

There is also issue with pre-change git automatically removing empty
directories, but that is probably matter for pre-commit hook to check,
or pre-receive hook in publishing repository.
-- 
Jakub Narebski
Poland
ShadeHawk on #git
