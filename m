From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pathspec: rename per-item field has_wildcard to
 use_wildcard
Date: Wed, 06 Apr 2011 10:13:02 -0700
Message-ID: <7vfwpvjobl.fsf@alter.siamese.dyndns.org>
References: <7vr59gl581.fsf@alter.siamese.dyndns.org>
 <BANLkTikJ3=H_OgcNueMjnwwQ2W-2kamf=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 06 19:13:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7WIC-0005Ut-Vf
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 19:13:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755481Ab1DFRNP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2011 13:13:15 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54968 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754224Ab1DFRNO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2011 13:13:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 44C754DCE;
	Wed,  6 Apr 2011 13:15:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lKXqYFcCiQmZE4TOPE55kL2PTpk=; b=KDF8M/
	EHif9Zq3pS+PGOJb/jWZ0bj8IFV+8GUTRJ6QZ0QJpzhE7WVbmK7d1SeN1+R+0akW
	VfFk6kjzr6HXUxn98vwW6H2oc9aENOLortV9Ql7RS7jm1K/WmEoee8DK+o77D5Fy
	uoAGLDXlz+gn7qCDcQRpiI48Yb7CEbdW6nGLU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kQFFKz+zpoPQ9iua1wQwGwRvSwI2LrhU
	PcnhI5ur99A8ukVMIrMYzW4IxZJTTZrwsNDGp++oeHOs+EJCtkeLCIBBy3W/ZmXC
	nNWt36keQrM67N2QFhua7mpvV+p+ygTJ8Y6rQhg4DimyD7dq3dIeMu087MH2tRtr
	3fTt5V0IZZ4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1207C4DCD;
	Wed,  6 Apr 2011 13:15:03 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B2E274DCA; Wed,  6 Apr 2011
 13:14:58 -0400 (EDT)
In-Reply-To: <BANLkTikJ3=H_OgcNueMjnwwQ2W-2kamf=w@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Wed, 6 Apr 2011 22:54:19 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 68F967A0-6071-11E0-B773-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170992>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> 2011/4/6 Junio C Hamano <gitster@pobox.com>:
>
> I have started working on the conversion, but it may take a while
> because in many places pathspec is still assumed a prefix (and handled
> separately, which is not good for negative pathspec). Fundamental
> support for magic pathspec and "top dir" notation probably do not need
> get_pathspec() converted to struct pathspec.

I think you meant to say "If we only want to have 'top dir' magic,
fundamental support and get_pathspec() conversion are unnecessary", and I
agree 100%.

I am actually tempted to add Michael's hack to get_pathspec() only to
support the "from the top" (and error out with any other magic---as the
approach without a proper restructuring will not work with anything but
that particular magic), to get the "add -u" topic going, and let you (or
other people who are interested in the pathspec rationalization) later fix
it up just a small part of existing issues.

The extensible syntax I have in mind (we only parse in get_pathspec() in
such a tentative version but anything other than the :/ will error out) is
to use:

 (1) Colon, a run of selected non-alpha (i.e. magic signature), an
     optional colon to terminate the magic signature, followed by the
     path, e.g.

     - ":/hello.c" is a path from the top.

     - ":!/hello.c" is path from the top but no globbing.

     - ":/!hello.c" is the same as above.

     - ":/::hello.c" is ":hello.c" from the top, the second colon
       terminates the magic signature and allows the funny file with a
       leading colon to be named.

     - "::hello.c" does not have any magic, is the same as "hello.c".

 (2) Colon, open parenthesis, a comma separated list of words to name
     magic, close parenthesis, followed by the path, e.g. these are the
     long-hand counterparts to the examples in (1)

     - ":(top)hello.c"
     - ":(top,noglob)hello.c"
     - ":(noglob,top)hello.c"
     - ":(noglob,top):hello.c"
     - ":()hello.c"

At this point, I am not interested in building the repertoire of magic
yet, but would want to nail a syntax that is

 - concise in common cases (e.g. "from the top, not a funny name" is ':/'
   followed by the name);
 - is extensible in the future; and
 - easy to parse and error out on magic we do not understand.
