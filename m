From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fast-import: Create import-marks file when necessary
Date: Sun, 09 Jan 2011 14:48:45 -0800
Message-ID: <7vwrmd7kxe.fsf@alter.siamese.dyndns.org>
References: <1294601637-18416-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 09 23:49:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pc44O-0000r3-Ac
	for gcvg-git-2@lo.gmane.org; Sun, 09 Jan 2011 23:49:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752377Ab1AIWs5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jan 2011 17:48:57 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50442 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750934Ab1AIWs4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jan 2011 17:48:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 36611360C;
	Sun,  9 Jan 2011 17:49:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hvHIPhVBtqfyem1ByGebrY5i91o=; b=mq/eEH
	KsIBMKDfC0nrs7DfAvbiebEIeI1NJsZqlez9JIoFpmFs2CCBMqqQ0XNkMYMTvt/w
	bNl6E/FZBG3kbcGTb1bhhp5oE3pCMCVrX0hZgyrnN+rrN1tcGGT0BNVcksolSP42
	EaCG+5UNtKZh3BXEIQQfeRtKdZghrjh9QWVf0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=n9C2aOGqY0YTKeyJteLY5gNAjrwxpzh9
	eaHyT7AmdNQ+1uQ+juTPXrVxBIHPp8DgizFJlGjpcqes0MF8sJ2JePmU/I19UrFn
	ACWhzZs37NqAOGrquerBt/KBwYeV18sFP22kPEH3MX0XepfxXLVjTz0daMjHcBF/
	D1HZl4e8cf0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 013A6360B;
	Sun,  9 Jan 2011 17:49:31 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C7CE43609; Sun,  9 Jan 2011
 17:49:27 -0500 (EST)
In-Reply-To: <1294601637-18416-1-git-send-email-artagnon@gmail.com> (Ramkumar
 Ramachandra's message of "Mon\, 10 Jan 2011 01\:03\:57 +0530")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B9147A4A-1C42-11E0-BEB9-CBB45B885003-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164865>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> When both --import-marks and --export-marks are given, and specify the
> same file, that file should be created if it doesn't exist. Without
> this patch, the caller would have to check for the existence of a
> marks file and vary its fast-import invocation accordingly.
>
> Requested-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>

Do you mean that you are solving a problem for bootstrapping a script that
says "read from this file if exists, do work, and then write to the same
file for later invocation"?

Assuming that is what you are solving, why do you create the file in your
patch in the import codepath?  I would imagine a sane logic flow for "read
if exists, do work and then write to the same" would be more like:

	if (import_marks) {
		FILE = *f = fopen(import_marks);
                if (f)
                	read_marks();
		else if (errno == ENOENT && !strcmp(import_marks, export_marks))
                	; /* Bootstrapping with "read if exists" */
		else
                	barf();
	}

no?

Also I find it a bad taste to use "The user gave the same file to import
and export" as a hint for "read if exists".

The first two lines of the proposed commit message is way suboptimal, if
the problem is "Not allowing read-if-exists-but-do-not-barf-if-missing
makes it hard to bootstrap repeated invocations that use a single
import/export marks file as the state-keeping mechanism".

It does not have to be created if it doesn't exist---the program only
needs not to barf.  The condition does not have to be "if they are the
same file".  The caller may want to script

	command --import-if-exists=state --export=new-state+ &&
        mv new-state+ state

to make sure that when the underlying command fails, the previous state is
still kept intact without getting overwritten.
