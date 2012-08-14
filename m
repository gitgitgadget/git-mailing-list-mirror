From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What should mergetool do with --no-prompt?
Date: Tue, 14 Aug 2012 10:23:58 -0700
Message-ID: <7v1uj9bd5d.fsf@alter.siamese.dyndns.org>
References: <CAJDDKr5TK910n603jcmoq6WoaLL9DX9hgwF3Y+MmjngMpAXPQw@mail.gmail.com>
 <20120814071823.GA21031@hashpling.org>
 <7vehn98qcv.fsf@alter.siamese.dyndns.org>
 <20120814170900.GA28978@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Tim Henigan <tim.henigan@gmail.com>
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Tue Aug 14 19:24:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1Kqe-0001cz-Dh
	for gcvg-git-2@plane.gmane.org; Tue, 14 Aug 2012 19:24:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755360Ab2HNRYC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Aug 2012 13:24:02 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35533 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752809Ab2HNRYB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2012 13:24:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D3C6D658F;
	Tue, 14 Aug 2012 13:24:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uKygvVm/KCd4eUbx4jp3ngH667E=; b=RgCkeM
	dPFiq5c0s7frPXG8dwapUt3HbXMRyJu6qQ+4o6oPxZrW2fLpVIfmFV/j4Oq6bRUt
	Mhhq6/IeCIJ+QQQ0S4d8epCeQkLzDUrwGY9PocZYGFsQkNfaixHfV2vpmtqUPSB5
	hfIBIre0IqluvO71EU/sqwLvzAt5aaJU5Sb94=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=v9S65lHTih+xjsu/x2J1ITkJut2D6MVo
	KibOD3MH/ggT6wClITqh0bPS2etn5RnRu28Qx9WRaBifPzmQgofr30WkG/r2PEGP
	G9eoPIN2dg9gDCFT/uuRTXagfLyp4jinmM+b2c5vgoNw69znG1kDX4evX547Mbkv
	pca7XNW/P9E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B73B0658E;
	Tue, 14 Aug 2012 13:24:00 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 32265658D; Tue, 14 Aug 2012
 13:24:00 -0400 (EDT)
In-Reply-To: <20120814170900.GA28978@hashpling.org> (Charles Bailey's message
 of "Tue, 14 Aug 2012 18:09:00 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D613F0F4-E634-11E1-A6CB-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203418>

Charles Bailey <charles@hashpling.org> writes:

> On Tue, Aug 14, 2012 at 08:06:56AM -0700, Junio C Hamano wrote:
>> 
>> Could it be that the calling user or script does not even have a
>> terminal but still can spawn the chosen mergetool backend and
>> interact with the user via its GUI?  Or it may have a terminal that
>> is hard for the user to interact with, and the prompt and "read ans"
>> may get stuck.
>
> It could be, although this certainly wasn't considered in the original
> design. I know that we removed explicit references to /dev/tty and
> replaced them with exec n>&m juggling which made things generally more
> robust and allowed some basic shell tests to work more reliably. I
> don't object to handling non-interactive mode better but it feels
> unsatisfactory to only be able to resolve some types of conflict and
> have to skip others.

Exactly.  The mention of "a matching GUI" below you quoted was a
suggestion to improve that "only resolve some but not others"
problem.  The usual mergetool backend, e.g. meld, may not be capable
of resolving symlink conflicts, but "git mergetool" could run a GUI
dialog that gives the user "ours/theirs/fail" choice (or better yet
"merge result value" textbox in addition) for such a path.  The same
for delete/modify conflicts.

>> In such an environment, the ideal behaviour for the "git mergetool"
>> frontend may be not to interact via the terminal at all and instead
>> run its interaction to choose the resolution using a matching GUI
>> interface.
