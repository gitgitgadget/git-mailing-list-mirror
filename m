From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Problem pushing to a Novell share
Date: Thu, 02 Feb 2012 15:45:16 -0800
Message-ID: <7vmx90vlyr.fsf@alter.siamese.dyndns.org>
References: <CAJ4nRM0-3GWN=OYOXDdGtktU0mc8mhcoKqbo=U4Jm5AmSbPAyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?R=C3=BCdiger?= Kessel <ruediger.kessel@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 03 00:45:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rt6LL-0003va-LK
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 00:45:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757754Ab2BBXpY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Feb 2012 18:45:24 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55672 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757735Ab2BBXpT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Feb 2012 18:45:19 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9C6F77B90;
	Thu,  2 Feb 2012 18:45:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=XJBtG6F6NUaA
	8EPTFeGDYUZVYts=; b=T/DvwOx6eChsdjNq31OQx5BrcCZ5nktEQ61n+OkSLYjv
	QLXh6SXdg0ZNjmuzzkT8YCZnZai7eB6CAzP3QmJoRubTy6A9bkfQDhrUrnT9JWa8
	6G1O+g5pj6tbnQOGBlbyTym5799EgID2Ot4VE4rO8iYR3pmOTxXxB3ZPztiDMlk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Q2G/In
	VwmD34H9T54o3Ox70UG7Jfb8INOAqpQwpmqncB+iqNiI1aZlQo9DP9yhDjIY37uR
	W7vqcaDWfJugxCfBldVK79HO/UDi0HNlLc7qmcgz2SWoL77Gvx4qJHBMxCesarFr
	c6+K1seqX+GLeJ/JQ73lXkZGB9XvVwaZ69yM0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 92A307B8F;
	Thu,  2 Feb 2012 18:45:18 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0D6387B8E; Thu,  2 Feb 2012
 18:45:17 -0500 (EST)
In-Reply-To: <CAJ4nRM0-3GWN=OYOXDdGtktU0mc8mhcoKqbo=U4Jm5AmSbPAyQ@mail.gmail.com>
 (=?utf-8?Q?=22R=C3=BCdiger?= Kessel"'s message of "Thu, 2 Feb 2012 23:54:44
 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F63367B4-4DF7-11E1-B099-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189721>

R=C3=BCdiger Kessel <ruediger.kessel@gmail.com> writes:

> A quick fix is to improve the create_tmpfile() function in sha1_file.=
c:
>
> static int create_tmpfile(char *buffer, size_t bufsiz, const char *fi=
lename)
> {
>     static struct stat sb;
>     int fd, dirlen =3D directory_size(filename);
>
>     if (dirlen + 20 > bufsiz) {
>         errno =3D ENAMETOOLONG;
>         return -1;
>     }
>
>     memcpy(buffer, filename, dirlen);
>     buffer[dirlen-1] =3D 0;
>     if (stat(buffer, &sb) !=3D 0 && errno =3D=3D ENOENT) {
>         if (mkdir(buffer, 0777) || adjust_shared_perm(buffer))
>             return -1;
>     }
>
>     memcpy(buffer, filename, dirlen);
>     strcpy(buffer + dirlen, "tmp_obj_XXXXXX");
>     fd =3D git_mkstemp_mode(buffer, 0444);
>     return fd;
> }
>
> The function will create one missing directory level if it does not
> exist prior to creating the tmp-file.

Please remove your modification above, and follow the code we have.  We
try git_mkstemp_mode() first, because it is more common than not having
the leading directory and we do not want to waste an extra stat() every
tie we come here.  Only when the first attempt fails by returning error
(i.e. fd < 0 and errno =3D=3D ENOENT), we try mkdir() and then try agai=
n.

If you see "missing directory", it would be because on your system the
code somehow does not notice the failure from the first attempt.  Why?

The breakage you are seeing could come from either:

 - git_mkstemp_mode(), more specifically, the underlying mkstemp(), not
   returning negative when it fails for some reason; or

 - when the above fails, it fails to set errno to ENOENT.

and *that* is what needs to be fixed.

I think pessimizing create_tmpfile() like you did is not a fix; it is
sweeping the real problem under the rug.
