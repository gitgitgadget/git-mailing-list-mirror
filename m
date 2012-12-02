From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] "diff --stat" counting fixes
Date: Sat, 01 Dec 2012 18:23:22 -0800
Message-ID: <7vhao5mbtx.fsf@alter.siamese.dyndns.org>
References: <1354051310-29093-1-git-send-email-gitster@pobox.com>
 <CALWbr2xYrWkfSCUc7gocVGLQP_RHjWrMmFspPe5O_ekjisNqxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 02 03:24:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TezEo-0003kR-FJ
	for gcvg-git-2@plane.gmane.org; Sun, 02 Dec 2012 03:24:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751702Ab2LBCX0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Dec 2012 21:23:26 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33337 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751573Ab2LBCX0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Dec 2012 21:23:26 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 445D2A94E;
	Sat,  1 Dec 2012 21:23:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RT3wT7rVYjW1iMlBwpO0IGSN7to=; b=Xc6eOJ
	NVSbsLqiJBqi6HeGDBMOP5yn8SwFdPxW1yrraYRdtXafU5sP2niquIzHEa5P3sa4
	2BFXFToMt4jbve7KX/AOBJw5VH9Nr5SKpJqBCiJ0HhNIwMCvEbpX7RBeYdLpW3QO
	Qxte7SKQR6zMRpzRnzq5RvuG1MIbKYBLWUZkQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ygL+6xhrkHH2YzfRasBgbbuH1qlmldyT
	QOM1Bh9rDT40fl3FYT10iNITmycSF9sb6uSVSEUel0gfB3XbV+s7R3OGSIcSqR+s
	EGCqoZj7L+OjS/41zX+x8qG3x65wtPuxj4ZgX5mqeCQDoLnOnHRN4RcK8D3QeLGY
	+mnICVlYeTg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 306F7A94D;
	Sat,  1 Dec 2012 21:23:25 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8C8DCA94C; Sat,  1 Dec 2012
 21:23:24 -0500 (EST)
In-Reply-To: <CALWbr2xYrWkfSCUc7gocVGLQP_RHjWrMmFspPe5O_ekjisNqxw@mail.gmail.com> (Antoine
 Pelisse's message of "Sat, 1 Dec 2012 11:29:53 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3FC56BD4-3C27-11E2-9754-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210991>

Antoine Pelisse <apelisse@gmail.com> writes:

> I feel like (but I can obviously be wrong):
> 1. The info is redundant. When performing a merge, all diffs (without
> --staged flag) are unmerged

Yes, it is redundant.  They are primarily meant as a warning to
anybody who runs "git diff --stat" while their index is not fully
merged so that they do not mistakenly think they are looking at
meaningful numbers.  The number of added lines likely includes the
conflict markers you haven't dealt with ;-)

> 2. While status shows the line once, while diff shows the diff for the file
> once, while diff --shortstat counts the file once, diff --stat shows two
> lines for the file.

Yeah, don't use shortstat while your index is unmerged.

> 3. diff --numstat shows two lines for the same file. As a script
> writer (I guess that's what it's meant for), I would definitely expect
> uniqueness in third column/filenames.

Then your script wouldn't receive any hint in the output that you
are reading from a nonsense input.  When you see the same filename
twice, you will know there is something strange (not just "I seem to
have more added lines than I thought I added -- Ah, I see added
files from both sides because I still have conflicts unresolved")
that gives you a chance to notice.
