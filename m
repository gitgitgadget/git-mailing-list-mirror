From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFD: concatening textconv filters
Date: Thu, 21 Feb 2013 09:39:46 -0800
Message-ID: <7vzjyxva59.fsf@alter.siamese.dyndns.org>
References: <5125F6CF.50105@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Feb 21 18:40:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8a81-0003h5-Uj
	for gcvg-git-2@plane.gmane.org; Thu, 21 Feb 2013 18:40:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755522Ab3BURjx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Feb 2013 12:39:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47210 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754597Ab3BURjw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Feb 2013 12:39:52 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 792D5A1DF;
	Thu, 21 Feb 2013 12:39:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=GqquXmGmwKfB
	8SxXV7D7sW8GQFU=; b=eCODOvl4eYj+Fd5dY9w841mW5G6k8FNldSbZZwB4Q0CA
	hTHx6A7OaXGXyY8wFnUj+XljfJJp2oNObM4G8BhcnZjzYRvJ9asDW4wiPEM309Xi
	Aw48ROC0N0qMqSh9+DciR6S/H4hT3nfDFg6O9usf0wpyGl2EdctwBlAdNPN2FU8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=QzuCao
	rjVl3p7jWI1KId9G9kcY9WWXfolYvmIqIEK74SfZrda7vUsCfvKKiiM/PDLaZJSd
	E74G5ELMnwbPDvJFqHixtYPZH/hIt2v/qOQMkeJyDmovuVh1BX3arY4bwMfPIO4X
	pmA/iD83zr0kfBl8xt4JBwqELhayK1z9wSvvw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6AF57A1DE;
	Thu, 21 Feb 2013 12:39:49 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9352AA1D9; Thu, 21 Feb 2013
 12:39:48 -0500 (EST)
In-Reply-To: <5125F6CF.50105@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Thu, 21 Feb 2013 11:28:31 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B0442B3C-7C4D-11E2-8B92-27D12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216781>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> ... but wondering
> whether we could and should support concatenating filters by either
>
> - making it easy to request it (say by setting
> "filter.gpgtopdftotext.textconvpipe" to a list of textconv filter nam=
es
> which are to be applied in sequence)
>
> or
>
> - doing it automatically (remove the pattern which triggered the filt=
er,
> and apply attributes again to the resulting pathspec)

I think what you are getting at is to start from something like this:

	=3D .gitattributes =3D
	*.gpg	diff=3Dgpg
        *.pdf	diff=3Dpdf

and have "git cat-file --textconv frotz.pdf.gpg" (and other textconv
users) notice that:

 (1) The path matches "*.gpg" pattern, and calls for
     diff.gpg.textconv conversion.  This already happens in the
     current system.

 (2) After stripping the "*.gpg" pattern (i.e. look at the part of
     the path that matched the wildcard part * in the attribute
     selector), notice that the remainder, "frotz.pdf", could match
     the "*.pdf" pattern.  The output from the previous filter could
     be treated as if it were a blob that is stored in that path.

A few issues that need to be addressed while designing this feature
that come to my mind at random are:

 * This seems to call for a new concept, but what exactly is that
   concept?  Your RFD sounds as if you desire a "cascadable
   textconv", but it may be of a somewhat larger scope, "virtual
   blob at a virtual path", which the last sentence in (2) above
   seems to suggest.

 * What is this new concept an attribute to?  If we express this as
   "the textconv conversion result of any path with attribute
   diff=3Dgpg can be treated as the contents of a virtual blob", then
   we are making it an attribute of the gpg "type", i.e.

	=3D .git/config =3D
	[diff "gpg"]
		textconv =3D gpg -v
		textconvProducesVirtualBlob =3D yes

   To me, that seems sufficient for this particular application at
   the first glance, but are there other attributes that may want to
   produce such virtual blob for further processing?  Is limiting
   this to textconv too restrictive?  I do not know.

 * What is the rule to come up with the "virtual path" to base the
   attribute look-up on for the "virtual blob contents"?  In the
   above example, the pattern was a simple "*.gpg", and we used a
   na=C3=AFve "what did the asterisk match?", but imagine a case where
   you have some documents that you want to do "gpg -v" and some you
   don't.  You express this by having the former class of files
   named with "conv-" prefix, or some convention that is convenient
   for you.

   Your .gitattributes may say something like:

	=3D .gitattributes =3D
        conv-*.gpg	diff=3Dgpg

   When deciding what attributes to use to further process the
   result of conversion (i.e. "virtual blob contents") for
   conv-frotz.pdf.gpg, what virtual path should we use?  Should we
   use "conv-frotz.pdf", or just "frotz.pdf"?

   "The difference does not matter--either would work" is not a
   satisfactory answer, once you consider that you may want to have
   two or more classes of pdf files that you may want to treat
   differently, just like you did for gpg encrypted files in this
   example setting.  It seems to suggest that we want to use
   conv-frotz.pdf as the virtual path, but how would we derive that
   from the pattern "conv-*.gpg" and path "conv-frotz.pdf.gpg"?  It
   appears to me that you would need a way to say between the two
   literal parts in the pattern, "conv-" part needs to be kept but
   ".gpg" part needs to be stripped when forming the result.
