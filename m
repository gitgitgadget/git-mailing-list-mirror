From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add: add --bulk to index all objects into a pack file
Date: Wed, 02 Oct 2013 23:43:45 -0700
Message-ID: <xmqqsiwin9b2.fsf@gitster.dls.corp.google.com>
References: <1380772811-15415-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 03 08:43:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VRcde-0002fm-Q5
	for gcvg-git-2@plane.gmane.org; Thu, 03 Oct 2013 08:43:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753766Ab3JCGnu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Oct 2013 02:43:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60209 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752899Ab3JCGns convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Oct 2013 02:43:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 084E740D1D;
	Thu,  3 Oct 2013 06:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Bx+MS2TG3XpH
	/koynBCtf7sDwPk=; b=xc2yWL6EF5JUUIOEUD2+BRKPV3IPRCecYUqpjBaIqLoh
	fqts1/hVvHOqpwcCWm7EmDrvol6S6wZkyIKfmvxrsksV0qYW1TmvjXHPU/86fd7U
	IYn4RJdpsNhVfFmuz6IyQKtGZod1H60iWFVWCzbM3DfZRwCiIgdR+BIllVy21Ec=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=eKpHQW
	Ow8v8vDJbKIjnoKv+vE0vfl40zylqPL3SgtJOO9z2JVnfV8C1IV9pw1V3o7Q5uDX
	npI07nUqlIRoDZPo+OYRN00jOT8Zaps65d4w/hg4e0QS/s7HDsphXOBdPYodXP7R
	8ZbabYnF6HtBfGl4dytU2yg/bLFsJw0ExiUls=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EFB8B40D1C;
	Thu,  3 Oct 2013 06:43:47 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 64DD840D13;
	Thu,  3 Oct 2013 06:43:47 +0000 (UTC)
In-Reply-To: <1380772811-15415-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 3 Oct
 2013 11:00:11 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 27B30DE2-2BF7-11E3-81E4-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235681>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> The use case is
>
>     tar -xzf bigproject.tar.gz
>     cd bigproject
>     git init
>     git add .
>     # git grep or something

Two obvious thoughts, and a half.

 (1) This particular invocation of "git add" can easily detect that
     it is run in a repository with no $GIT_INDEX_FILE yet, which is
     the most typical case for a big initial import.  It could even
     ask if the current branch is unborn if you wanted to make the
     heuristic more specific to this use case.  Perhaps it would
     make sense to automatically plug the bulk import machinery in
     such a case without an option?

 (2) Imagine performing a dry-run of update_files_in_cache() using a
     different diff-files callback that is similar to the
     update_callback() but that uses the lstat(2) data to see how
     big an import this really is, instead of calling
     add_file_to_index(), before actually registering the data to
     the object database.  If you benchmark to see how expensive it
     is, you may find that such a scheme might be a workable
     auto-tuning mechanism to trigger this.  Even if it were
     moderately expensive, when combined with the heuristics above
     for (1), it might be a worthwhile thing to do only when it is
     likely to be an initial import.

 (3) Is it always a good idea to send everything to a packfile on a
     large addition, or are you often better off importing the
     initial fileset as loose objects?  If the latter, then the
     option name "--bulk" may give users a wrong hint "if you are
     doing a bulk-import, you are bettern off using this option".

This is a very logical extension to what was started at 568508e7
(bulk-checkin: replace fast-import based implementation,
2011-10-28), and I like it.  I suspect "--bulk=3D<threashold>" might
be a better alternative than setting the threshold unconditionally
to zero, though.
