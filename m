From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: check return value of lookup_commit()
Date: Mon, 15 Aug 2011 10:46:58 -0700
Message-ID: <7vei0mlg8d.fsf@alter.siamese.dyndns.org>
References: <1313422716-26432-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 15 19:47:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qt1Fk-00009j-M0
	for gcvg-git-2@lo.gmane.org; Mon, 15 Aug 2011 19:47:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752196Ab1HORrD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Aug 2011 13:47:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42786 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751422Ab1HORrC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Aug 2011 13:47:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B72A84035;
	Mon, 15 Aug 2011 13:47:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=KqjYVSXwVhod
	lD+SDpqNcesUhvs=; b=bNugIDbQB7i+HYtHKz/QWJy5GQel+xD+G+1cLfnR5VLZ
	s+pyA9Asaxh57ECaqgi8CZdsKT/7Ar4/yvg0RdEwBYZA3D018Wgdg9jic+4qkj/4
	cjI3MjyRyzuPo8ijHLFCQ0DvZoRhlE4QCDyTAQGQK+twkLgh/xHTXIxh4uZGsXw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=tply12
	0ezQzC7LjQrPISBY4mfVB6pdrl28p+PEguHSjnFDeRoANeEQDzDmiRFNXjFKSHmW
	gHtFvf36j4AjAzw7WdhAnzl5MMvqURLP8lVjJ+OMp52dx8Z4F32rhhS8b/YpnYYD
	dpLIkOEi3fNKY1JtSIQxXS5XyLNqbR7OwWf0Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A81E94034;
	Mon, 15 Aug 2011 13:47:00 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 37D5F4033; Mon, 15 Aug 2011
 13:47:00 -0400 (EDT)
In-Reply-To: <1313422716-26432-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 15 Aug
 2011 22:38:36 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 93DC3838-C766-11E0-9870-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179382>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> If lookup_commit() returns NULL, there's usually serious error and th=
e
> command aborts anyway. However it's still nicer to have a message
> telling us where it aborts, rather than segmentation fault.

The change itself looks good to me but a point and a half to think abou=
t:

 - In this if/elseif/.../else cascade, everybody except for the
   "initial_commit" case needs to make sure that head_sha1 points at a
   valid commit and get an commit object. Hoisting the scope of the
   variable "commit" one level in your patch is good, but it would make=
 it
   easier to read and the future code modification much less error pron=
e
   if (1) you called lookup_commit() and checked for errors before
   entering this if/elseif/... cascade, and (2) you renamed this variab=
le
   to "head_commit".

 - Whether we like it or not, many people have a broken reimplementatio=
ns
   of git that can put a non-commit in HEAD, and they won't be fixed
   overnight. Instead of erroring out, would it be nicer of us if we ju=
st
   warned, unwrapped the tag and used the tagged commit instead?
