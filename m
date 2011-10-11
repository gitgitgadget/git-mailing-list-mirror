From: Peter Oberndorfer <kumbayo84@arcor.de>
Subject: Re: [RFC/WIP PATCH] Use config value rebase.editor as editor when starting git rebase -i
Date: Tue, 11 Oct 2011 23:16:11 +0200
Message-ID: <201110112316.11738.kumbayo84@arcor.de>
References: <201110111956.08829.kumbayo84@arcor.de> <7vipnvfk70.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 11 23:17:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDjhG-0002GK-Pg
	for gcvg-git-2@lo.gmane.org; Tue, 11 Oct 2011 23:17:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936Ab1JKVRF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Oct 2011 17:17:05 -0400
Received: from mail-in-16.arcor-online.net ([151.189.21.56]:41459 "EHLO
	mail-in-16.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750780Ab1JKVRD (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Oct 2011 17:17:03 -0400
Received: from mail-in-07-z2.arcor-online.net (mail-in-07-z2.arcor-online.net [151.189.8.19])
	by mx.arcor.de (Postfix) with ESMTP id 06F7A891F;
	Tue, 11 Oct 2011 23:17:02 +0200 (CEST)
Received: from mail-in-12.arcor-online.net (mail-in-12.arcor-online.net [151.189.21.52])
	by mail-in-07-z2.arcor-online.net (Postfix) with ESMTP id 045A8E1973;
	Tue, 11 Oct 2011 23:17:02 +0200 (CEST)
Received: from soybean.localnet (188-22-107-88.adsl.highway.telekom.at [188.22.107.88])
	(Authenticated sender: kumbayo84@arcor.de)
	by mail-in-12.arcor-online.net (Postfix) with ESMTPSA id E39BB268E6;
	Tue, 11 Oct 2011 23:17:01 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-12.arcor-online.net E39BB268E6
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1318367822; bh=LM9pIH993U+5V1sY7jNffNP2L0+fI1wEB+ahnNELkbs=;
	h=From:To:Subject:Date:Cc:References:In-Reply-To:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id;
	b=Cw4JLdiLqLldT/1rstGlzFUTn1JL17/8m/gAAcKLV2Lp4uPPGEA4LW3RJnarPAG/K
	 8ZJ6Ycn7ORaQTNE7yQFIlrEBp9p98gZWEUdZeqUDqmtB1MudWFzbcQm32esFYcMNxQ
	 3s9l9L4cicmXU+uXByNTKf+Y0kJlyUHqi7vMjuog=
User-Agent: KMail/1.13.6 (Linux/2.6.38-11-generic-pae; KDE/4.6.2; i686; ; )
In-Reply-To: <7vipnvfk70.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183326>

On Dienstag, 11. Oktober 2011, Junio C Hamano wrote:
> Peter Oberndorfer <kumbayo84@arcor.de> writes:
> 
> > Using $GIT_EDITOR or core.editor config var for this is not possible
> > since it is also used to start the commit message editor for reword action.
> 
> Your tool _could_ be smart about this issue and inspect the contents to
> launch a real editor when it is fed a material not for sequencing, but
> that feels hacky.

I already tried this, but my first version did not redirect stdin/stdout
so vi stayed in background and the whole thing just hung.
I did not try further because i assumed more problems would appear
when redirecting stdin/stdout...

> > * GIT_EDITOR env var is not honored anymore after this change.
> 
> Care to explain?  "git var" knows magic about a few variables like
> GIT_EDITOR and GIT_PAGER.
> 
> 	$ git config core.editor vim
> 	$ GIT_EDITOR=vi EDITOR=emacs git var GIT_EDITOR
>         vi
> 	$ unset GIT_EDITOR; EDITOR=emacs git var GIT_EDITOR
>         emacs

Sorry i was wrong, i missed that git var looks at $GIT_EDITOR.

So the sequence for choosing the sequencer editor is:
$GIT_SEQUENCE_EDITOR
config sequence.editor
var GIT_EDITOR

Which looks OK to me.

> > * Should git_rebase_editor be in git-rebase--interactive.sh instead
> 
> Probably yes.

OK, will do.

> 
> > * How should the config be called?
> 
> Given that in the longer term we would be using a unified sequencer
> machinery for not just rebase-i but for am and cherry-pick, I would advise
> against calling this anything "rebase".  How does "sequence.edit" sound?
> 

I do not really care very much, but how about sequence.editor?
Sounds more similar to core.editor

> You need to be prepared to adjust your code to deal with new kinds of
> sequencing insns in the insn sheet and possibly a format change of the
> insn sheet itself.

I assume instruction sheet is the commented out part that looks like:
# Commands:
#  p, pick = use commit
#  r, reword = use commit, but edit the commit message

Currently all lines starting with # are ignored.
(They are also not written to the output when finished
which is a point I might have to change...)

Also the instructions are currently not taken from this instruction sheet.
They are all hardcoded.

Thanks for the feedback
Greetings Peter
