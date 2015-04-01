From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Clone from shallow bundle bug
Date: Tue, 31 Mar 2015 23:31:43 -0700
Message-ID: <xmqqtwx0mka8.fsf@gitster.dls.corp.google.com>
References: <551B0D37.5070407@ubuntu.com>
	<xmqqbnj8q0bm.fsf@gitster.dls.corp.google.com>
	<551B5E64.9070906@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Phillip Susi <psusi@ubuntu.com>
X-From: git-owner@vger.kernel.org Wed Apr 01 08:31:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YdCBq-0002Zt-L5
	for gcvg-git-2@plane.gmane.org; Wed, 01 Apr 2015 08:31:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751711AbbDAGbq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2015 02:31:46 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62971 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751030AbbDAGbp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2015 02:31:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C64CA3C5A7;
	Wed,  1 Apr 2015 02:31:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oEFpxaNShUx8vgWPNw4o9vBKk+k=; b=qEkV5a
	UgBICqNOJGIHEg5rn2YN18xR7c05AFjTojY/359N0kNKgFBiC7j0nb8sZHmMKoFL
	lMXpNZZ3vjWHtT154a5A8ryCxWESdHSSQOqFpOpEF4rA8XK4rYhZUKYieEjtgERP
	I8Tl0kXbPvH7PH/wfYS+1uDXiQk1YQ5j0QvZI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=av0CjMnPvDdei8QIblRttnpJRBUPh0W0
	ZY+ssdiEQ2Ie6bHba1ArdJ2EUxQqfk+7y3K/e91siWOX0n4f7J0tUyiQS5BNxtzs
	zzwnlv7L/BKtZ2nx8oZV9TRuBcDmx771NbgOtdipjM3ZrMeYEmtp9P3ySJOsGaJo
	YiaBJT3HIIE=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BEEF03C5A6;
	Wed,  1 Apr 2015 02:31:44 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 440FE3C5A2;
	Wed,  1 Apr 2015 02:31:44 -0400 (EDT)
In-Reply-To: <551B5E64.9070906@ubuntu.com> (Phillip Susi's message of "Tue, 31
	Mar 2015 22:56:36 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C3CFE468-D838-11E4-8010-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266593>

Phillip Susi <psusi@ubuntu.com> writes:

> On 03/31/2015 06:17 PM, Junio C Hamano wrote:
>> Phillip Susi <psusi@ubuntu.com> writes:
>> 
>>> I made a shallow clone of my repo, then used git bundle create to
>>> pack it all into a bundle file, then cloned from that bundle.
>> 
>> I think the introdution of shallow clone feature broke git bundle
>> create by not teaching it that its shallow boundaries are
>> prerequisite commits to unbundle its contents.  IOW, the bundle
>> created from the shallow clone is broken, I would think.
>
> It seems to me that it isn't exactly broken; it just needs to put
> something in the bundle noting ...

I think you are saying the same thing as I did without realizing ;-)

The only way a bundle can record "something" "noting" that it is an
incomplete history, while allowing it to be read by existing
implementations of "git bundle unbundle" is to list the commits,
behind which there is no history available in the bundle, as
bundle's pre-requisites.  I said that the addition of shallow repository
support did not enhance "git bundle create" to do so, and you are
saying "it just needs to put", implying that it currently does not.

Now, the only way the existing implementations of "git bundle
unbundle" can extract from such a bundle with prerequisites is to
unbundle into a repository that satisifies the prerequisites (these
incomplete bundle files are designed as a medium for sneaker-net
incremental updates).  I however suspect "git clone --shallow" from
such a bundle _might_ work (I never tried it), but I wouldn't be
surprised if the existing implementations of bundle unpacking code
refused to unbundle into a repository that lacks prerequiste commits
(i.e. making the repository a shallow-clone).

Allowing "git clone" (without "--shallow") from an incomplete bundle
file create a shallow clone, instead of outright refusing to work or
silently creating a corrupt repository, might be an interesting project,
perhaps the right size for GSoC or something like that.

Patches welcome, but one thing whoever is doing such a patch needs
to be careful about is that the pack data in the bundle is likely to
be a thin one---truly requiring the repository the bundle is unpacked
into to have the prerequisite objects.
