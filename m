From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] helping smart-http/stateless-rpc fetch race
Date: Mon, 08 Aug 2011 16:24:43 -0700
Message-ID: <7vty9rtrk4.fsf@alter.siamese.dyndns.org>
References: <7vbow337gx.fsf@alter.siamese.dyndns.org>
 <CAJo=hJvdMCyU-5wzy0p1r+QJxXU=DJTE+Mu5G6pk9iAwAD51mA@mail.gmail.com>
 <7vbow01ols.fsf@alter.siamese.dyndns.org>
 <7vsjpbzv07.fsf@alter.siamese.dyndns.org>
 <CAGdFq_i=8p4jvKo1C=UFpmQyPtUd9JOtr9VW8vn7viC0dQkQmg@mail.gmail.com>
 <20110808230812.GA16974@LK-Perkele-VI.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Tue Aug 09 01:24:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqZBj-0001w3-JZ
	for gcvg-git-2@lo.gmane.org; Tue, 09 Aug 2011 01:24:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752229Ab1HHXYq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Aug 2011 19:24:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48531 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751080Ab1HHXYp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2011 19:24:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3BEC14676;
	Mon,  8 Aug 2011 19:24:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=G17zFbcacUzmlPtfTkDspKYiyTE=; b=ezAC5X
	UKVnqB9Kyw5X3FlwK9TqvhfPkiPtwxK0WlorgCXZhzzT8J6CbwyZ4Z9cdFqhKDQy
	IhFMFIRLM7hGP21BwyrLHFO/h6jhFJXOhbaOMwsJp/i/plcbsjGeWrHsTABfXicy
	kBN8nMPIJg01Rc8ceX34g/rAtdsYAZ4xtQmeI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rwafIb6szr4pGsOdHkV3YqUr7Po/h3AM
	IGGUHuJK9yN+PbwTgYrDzS+qQpbsKD7R7jFrMTc9iDebwSQ80MYR+bBgynX9We0G
	GtO4OeRIWjDZ5v23+N+5zWP/eSSexB/VczwoVjvPF8H7v86/yowRH4fTIYJDl3k1
	JQ6I/HIyFhE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 33D394674;
	Mon,  8 Aug 2011 19:24:45 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B868A4673; Mon,  8 Aug 2011
 19:24:44 -0400 (EDT)
In-Reply-To: <20110808230812.GA16974@LK-Perkele-VI.localdomain> (Ilari
 Liusvaara's message of "Tue, 9 Aug 2011 02:08:12 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 99916A88-C215-11E0-8D1E-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179007>

Ilari Liusvaara <ilari.liusvaara@elisanet.fi> writes:

> On Mon, Aug 08, 2011 at 11:05:27PM +0200, Sverre Rabbelier wrote:
>> Heya,
>> 
>> On Mon, Aug 8, 2011 at 19:13, Junio C Hamano <gitster@pobox.com> wrote:
>> >>  (1) It might make sense to give admins who run upload-pack not behind
>> >>      smart-http an option to allow fetching from a non-tip; and
>> 
>> You said earlier it isn't needed since the server process caches the
>> refs for git and ssh, that leaves dumb-http right?
>
> It seems that everything currently possible falls into three
> categories:
>
> 1) Stateful upload-pack (git://, file://, ssh://, CONNECT): No fix
> needed.
> 2) Stateless upload-pack (smart http://, some bizarre helper):
> Needs fix to avoid races.
> 3) Dumb protocols (dumb http://, ftp://, rsync://): Won't invoke
> upload-pack anyway, no fix needed.
>
> So I think that the only thing that needs the option to allow
> fetching from non-tips is anything using --stateless-rpc.

These (1) and (2) were never meant to be fixes to work around the
smart-http protocol limitation; I know "No fix _needed_" and it was never
a consideration to decide (or choose not to decide) about these two
points.

A separate option would allow admins to let their clients ask to fetch
4bc5fbf (that is v0.99~2) even if that commit is not at the tip of any ref
if they choose to. That is what (1) is about, and people who do not want
a separate option needs to argue that it is an unnecessary "feature".
