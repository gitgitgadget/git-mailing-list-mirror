From: Junio C Hamano <gitster@pobox.com>
Subject: Re: equal-tree-merges as way to make rebases fast-forward-able
Date: Mon, 30 Nov 2009 12:32:21 -0800
Message-ID: <7viqcrkb3e.fsf@alter.siamese.dyndns.org>
References: <cover.1259524136.git.brlink@debian.org>
 <7v8wdnooza.fsf@alter.siamese.dyndns.org> <200911302026.53933.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	"Bernhard R. Link" <brlink@debian.org>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Nov 30 21:32:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFCvH-0000Rr-Pg
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 21:32:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752369AbZK3Uc2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 15:32:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752196AbZK3Uc2
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 15:32:28 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64247 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751824AbZK3Uc1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2009 15:32:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3A06BA35DC;
	Mon, 30 Nov 2009 15:32:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=J1ref/HEmYOICeaf7Kzm+LgVv3A=; b=fPwrrE
	G6unR4Rwls9koVdGrvhMQx3nbhpq16czQ2874ey4X5ttT6rminn7X5rsW/cDvSbo
	dfS8pMua/9F2Ue263NzAKQafLACj1GeLVDHS9dYJJtl3ext1EEhksntoC2zgbcE4
	+X/pl2xX8deHtmz4QaB/VH/b9H91JARuaKjVU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bU9aXA1sUbW8Kgoy9JJLBA19VlxjNOSX
	c9+hTysE/clJcaDWYiJP8bpKicE5plctCbptrlIxKvV2ciRFybEDnkyRaM93SPEC
	ME7uLkMnzsXHYonDDLTMzJ2FcWr2UOAgl+EkmODSNupV92YMUMJymd4B65JDYeLA
	IDK1Tbz1u0Q=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 088BAA35DB;
	Mon, 30 Nov 2009 15:32:29 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7CD78A35DA; Mon, 30 Nov 2009
 15:32:23 -0500 (EST)
In-Reply-To: <200911302026.53933.j6t@kdbg.org> (Johannes Sixt's message of
 "Mon\, 30 Nov 2009 20\:26\:53 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7A8166AE-DDEF-11DE-A248-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134137>

Johannes Sixt <j6t@kdbg.org> writes:

> On Montag, 30. November 2009, Junio C Hamano wrote:
>> To avoid that, I think (1) the marker has to be more reliable than just
>> "happens to have the same tree", and (2) the traversal done by Porcelains
>> (your patches 3 thru 5) by default should be unaware of eqt.
>>
>> I don't know what a suitable marker should look like, though.  The marker
>> must be easily identifiable by the lowest level rev-list machinery, so it
>> needs to be a sign left somewhere in the commit object.
>
> Wouldn't the pathspec . be the marker:
>
>     git rev-list HEAD -- .
>
> follows only one of the branches that have identical trees.

Because I am saying that "this commit has two parents and they record the
identical trees" is a condition that is too weak to mark a special-purpose
merge to bind the latest and an earlier version of a series, your rev-list
example command line should not be the way to identify such a mark commit
and act differently upon seeing one.

Actually your command line is even weaker, I think, although it would not
make much difference in real-life.  The marker as currently Bernhard
implements not only has parents with identical trees, but the tree it has
also matches those of its parents.

You can make a commit that merges two branches that independently reached
the same conclusion (which git is designed to handle as an ordinary event
in real life), and amend that commit into an evil merge that has different
contents from its parents (which, I suspect, does not have much use in
practice), and your rev-list will drop one of the branches for even such a
commit, mistaking it as a marker when it is clearly not one.

My "it would not make much difference in real-life" in the two paragraphs
above comes purely from "such an evil merge would not have much use in
practice".  We should make sure that "two branches that reached the same
conclusion" is not mistaken with a marker this series introduces.
