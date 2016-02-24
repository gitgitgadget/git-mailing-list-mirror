From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git: submodule honor -c credential.* from command line
Date: Wed, 24 Feb 2016 15:36:01 -0800
Message-ID: <xmqq1t81smu6.fsf@gitster.mtv.corp.google.com>
References: <1456344559-2822-1-git-send-email-jacob.e.keller@intel.com>
	<CAGZ79kbSd4TRdgdcj2NUrc+pL7ATrGQNcfTYd57TuJtyZ5QBwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Mark Strapetz <marc.strapetz@syntevo.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 00:36:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYiyj-0004V3-8S
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 00:36:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758620AbcBXXgG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 18:36:06 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60761 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758600AbcBXXgE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 18:36:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3032C47DB2;
	Wed, 24 Feb 2016 18:36:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JCpvfWxEm24OHEZEuBsZZlf3RS8=; b=Abvbc8
	bYma3D8A5ySDeixDI0KH6MOegTi5PRmbBm+Kb/DLBn44BXZvgsyjL8pCTQeY4PH2
	L/ZVV4XAn4CROFNh5ogpQFncggB7kKUcWSSEmPS0nhmBOO2gEp0NxZzWJdUxHKjh
	qi3UbMXd6EYqeNSF5HqdGUeE26KAlJJr6QlAw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OpL146lSvhJ6WobPQSFIFsFR7u3j8J0J
	sWE7f4SA54bJTvQmr3Yg4/V2oOq14phjh77q/Y/CGrD3L5FmullK8bYV6MT/SUe+
	DWXD7s/rREAoK5pWk5qbHhhG+zZqMxG65tEAMFaBExZ+C5WlZhCFi5H75j6QzrMm
	UFgGqLUP8/Q=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 286A047DB1;
	Wed, 24 Feb 2016 18:36:03 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 530B747D9F;
	Wed, 24 Feb 2016 18:36:02 -0500 (EST)
In-Reply-To: <CAGZ79kbSd4TRdgdcj2NUrc+pL7ATrGQNcfTYd57TuJtyZ5QBwg@mail.gmail.com>
	(Stefan Beller's message of "Wed, 24 Feb 2016 15:27:30 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5D9E0DBC-DB4F-11E5-A485-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287280>

Stefan Beller <sbeller@google.com> writes:

> On Wed, Feb 24, 2016 at 12:09 PM, Jacob Keller <jacob.e.keller@intel.com> wrote:
>> From: Jacob Keller <jacob.keller@gmail.com>
>>
>> Due to the way that the git-submodule code works, it clears all local
>> git environment variables before entering submodules. This is normally
>> a good thing since we want to clear settings such as GIT_WORKTREE and
>> other variables which would affect the operation of submodule commands.
>> However, GIT_CONFIG_PARAMETERS is special, and we actually do want to
>> preserve these settings. However, we do not want to preserve all
>> configuration as many things should be left specific to the parent
>> project.
>>
>> Add a git submodule--helper function which can be used to sanitize the
>> GIT_CONFIG_PARAMETERS value to only allow certain settings. For now,
>> restrict this to only credential.* settings.
>
> I guess for now that subset is fine and will be expanded over time?

I think it is more like "we pass only what is known to be necessary
and safe, and right now, credential.* are the only such variables."

As the system evolves more, theoretically we might find more, but
let's not phrase it as if expanding is a good thing and a longer
term goal.
