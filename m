From: Shawn Pearce <spearce@spearce.org>
Subject: Re: How does receive-pack and pre-receive hook works ?
Date: Sun, 27 Jun 2010 00:00:51 -0700
Message-ID: <AANLkTikrSABpX8rFLIYwwQaN3zfnzEuqr6ugbPEOzo76@mail.gmail.com>
References: <AANLkTinYRF2m95MU2c817bK6mfehPt_OMBH45R6laNUe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Mahesh Vaidya <forvaidya@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 27 09:01:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSlrk-0004am-7C
	for gcvg-git-2@lo.gmane.org; Sun, 27 Jun 2010 09:01:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752762Ab0F0HBM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jun 2010 03:01:12 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:39069 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752698Ab0F0HBM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jun 2010 03:01:12 -0400
Received: by iwn7 with SMTP id 7so126191iwn.19
        for <git@vger.kernel.org>; Sun, 27 Jun 2010 00:01:11 -0700 (PDT)
Received: by 10.231.13.199 with SMTP id d7mr2984715iba.167.1277622071242; Sun, 
	27 Jun 2010 00:01:11 -0700 (PDT)
Received: by 10.231.206.13 with HTTP; Sun, 27 Jun 2010 00:00:51 -0700 (PDT)
In-Reply-To: <AANLkTinYRF2m95MU2c817bK6mfehPt_OMBH45R6laNUe@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149790>

On Sat, Jun 26, 2010 at 7:24 PM, Mahesh Vaidya <forvaidya@gmail.com> wrote:
> How does receive-pack and pre-receive hook works ?
>
> I Would like know where does Git saves whatever I am pushing before
> exit 0 of this hook; Specifically how does it understand about
> 'd6d147f432869037a7ac8bdca3a2d5bc0cdc1e9f' which is not part of
> destination depot / repo.

The objects that were sent are actually added to the destination
repository, by creating one or more loose objects in the objects/
directory, or a single new pack file in the objects/pack/ directory if
more than 100 objects were sent.  These objects are in the repository,
but they aren't actually reachable from any ref, so they are subject
to garbage collection during a future `git gc`.  Once the objects are
safely stored, the hooks are invoked... which means the hooks can
access the objects, as they are already part of the repository.

If pre-receive or update exits with a non-zero status, the objects
stay around, but the references aren't updated.  By not updating the
references, the objects aren't reachable, and the objects will be
automatically removed during a future `git gc`.

-- 
Shawn.
