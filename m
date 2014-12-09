From: Junio C Hamano <gitster@pobox.com>
Subject: Re: fast-import should not care about core.ignorecase
Date: Tue, 09 Dec 2014 12:19:52 -0800
Message-ID: <xmqqoarclgnr.fsf@gitster.dls.corp.google.com>
References: <20141209001211.GA13386@glandium.org>
	<54864B3D.6040503@workspacewhiz.com>
	<20141209013138.GU16345@google.com>
	<54866A94.2040305@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Mike Hommey <mh@glandium.org>, git@vger.kernel.org
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Tue Dec 09 21:20:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyRGK-0003d3-HQ
	for gcvg-git-2@plane.gmane.org; Tue, 09 Dec 2014 21:20:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752451AbaLIUT4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2014 15:19:56 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50844 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751963AbaLIUTz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2014 15:19:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9EF3A230AD;
	Tue,  9 Dec 2014 15:19:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Khqov6bdfpZAoC9cu8k8TtQBWbw=; b=yfatbN
	EoHuTQ0B+HyaWM2FhCPdzDSVV1DrEzwaHkTqhA18sgAlCRe9wkcVRLE5ngMYoleu
	jvaUbjcpJk3dAhQcsS+H7uTKDeTre6lzUz/4vjyskh0xfiN0M0O1bV/bEZTtZxKa
	/1rDmkdTCqYZkwwRZQANJ0LcnghYsZUyEr5rs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=F9MrNb5EJXlsFJ2a4Qug6B/xjSX3KGJT
	hOC8gVYYBXTjoCMTM27bkxwndxTG2GcUTvD8NCX09iruPD8euG9752MIVhyePFjW
	BSqHjzK2qXLMeKNVBij9E9TiP4p+EhPWD1Aqjp/vqDkrk51bXNcxOXikvOQVkMXo
	RckmmLzKzmk=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 94906230AA;
	Tue,  9 Dec 2014 15:19:54 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EAF64230A5;
	Tue,  9 Dec 2014 15:19:53 -0500 (EST)
In-Reply-To: <54866A94.2040305@workspacewhiz.com> (Joshua Jensen's message of
	"Mon, 08 Dec 2014 20:20:52 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BC7E5358-7FE0-11E4-B7EF-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261155>

Joshua Jensen <jjensen@workspacewhiz.com> writes:

> Jonathan Nieder wrote on 12/8/2014 6:31 PM:
>> Joshua Jensen wrote:
>>> I think it has been discussed before, but maybe Git needs a
>>> core.casefold in addition to core.ignorecase.)
>> Would it work for --casefold to be a commandline flag to fast-import,
>> instead of a global option affecting multiple Git commands?
> Given that core.ignorecase=true means to fold filename case in quite a
> number of places within Git right now, I would expect the same
> behavior within a repository where fast-import is being run against
> core.ignorecase=true.
>
> So, I don't know what core.ignorecase should mean, but I'm pretty sure
> I know what core.foldcase should mean.
>
> Would --casefold work?  Sure, but it would be a special case against
> the existing core.ignorecase behavior that I don't think makes much
> sense.

I would recommend doing this:

 - Add file-scope static variable fast_import_casefold to fast-import.c

 - Patch fast-import.c where it calls strncmp_icase(a, b) to read

    fast_import_casefold ? strcasecmp(a, b) : strcmp(a, b);

 - Initialize fast_import_casefold to the same value as ignore_case.

 - Add a new command line option "--[no-]casefold" to modify the
   value of fast_import_casefold.

Once all of the above is in place, optionally do this:

 - Add fastImport.casefold configuration variable.  The
   initialization logic for fast_import_casefold would then become:

    1. If the configuration is set, use that value; otherwise
    2. Use the same value as ignore_case.

 - Start warning when fast_import_casefold is set to true only
   because ignore_case is set (i.e. no "--[no-casefold]" is given
   from the command line or from the config), saying that this is
   true for now only as a backward compatibility measure and in a
   later version of Git we will flip the default _not_ to fold on
   any system.

 - Wait a bit and then flip the default.
