From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] remote-hg: fix 'shared path' path
Date: Tue, 17 Dec 2013 14:25:04 -0800
Message-ID: <xmqqzjnzktdr.fsf@gitster.dls.corp.google.com>
References: <1386421783-27781-1-git-send-email-felipe.contreras@gmail.com>
	<1386421783-27781-4-git-send-email-felipe.contreras@gmail.com>
	<CALWbr2wkSNDh2VTz05sndymUe=fOsApMrg6Jjp0a6mbEfhru=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	git <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 17 23:25:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vt34l-0000te-A6
	for gcvg-git-2@plane.gmane.org; Tue, 17 Dec 2013 23:25:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754284Ab3LQWZJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Dec 2013 17:25:09 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60880 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753733Ab3LQWZI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Dec 2013 17:25:08 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D1825C899;
	Tue, 17 Dec 2013 17:25:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HqhSWRR23n8Ppy/CuEIQ2M9rLmc=; b=um8Q/t
	EIrdGPcNDz8HLhP2gYt+7chHvUJLUdcTVignUFUJMGN5sVXOGmlIYyhypXIufTo8
	/b8H+vPFatvLqo08gcw0/I625kl8ZKU4db1SKPB9JCdS7nafhPdKohU9rI4Av22C
	4irBYCI7ag/Q2XT7rLdCZEkGD373VcExPgCAA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fji/Nsn4c0HGdRQ6Y+pYbRPU/Kfuln04
	L0NKfsz9ldg0L52SSUwMees+gRB4kqi5tucOT2dHmD2spzPpY2NiMk3wBQqdK3N7
	wfjJv/YiJhdBvfYLd/MAZzYaqow4IqvG80U/Wk5hKpnFysl9Xl0WMXNyMA6fOd77
	ImTHsTzaDeQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C7405C897;
	Tue, 17 Dec 2013 17:25:07 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7DADB5C896;
	Tue, 17 Dec 2013 17:25:06 -0500 (EST)
In-Reply-To: <CALWbr2wkSNDh2VTz05sndymUe=fOsApMrg6Jjp0a6mbEfhru=g@mail.gmail.com>
	(Antoine Pelisse's message of "Fri, 13 Dec 2013 18:58:04 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 14D9B532-676A-11E3-BBF5-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239407>

Antoine Pelisse <apelisse@gmail.com> writes:

> On Sat, Dec 7, 2013 at 2:09 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> If the repository is moved, the absolute path of the shared repository
>> would fail.
>>
>> Make sure it's always up-to-date.
>>
>> Reported-by: Michael Davis <mjmdavis@gmail.com>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>>  contrib/remote-helpers/git-remote-hg | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
>> index aa1d230..718ef95 100755
>> --- a/contrib/remote-helpers/git-remote-hg
>> +++ b/contrib/remote-helpers/git-remote-hg
>> @@ -416,6 +416,9 @@ def get_repo(url, alias):
>>          local_path = os.path.join(dirname, 'clone')
>>          if not os.path.exists(local_path):
>>              hg.share(myui, shared_path, local_path, update=False)
>> +        else:
>> +            # make sure the shared path is always up-to-date
>> +            util.writefile(os.path.join(local_path, '.hg', 'sharedpath'), hg_path)
>
> Considering this is modifying a "private mercurial file", would it
> make sense to include a test like I did in my equivalent patch ?

Hmph. I was planning to merge the topic to 'next' today; perhaps the
necessary tests can come as a follow-up patch on top of the topic
before it graduates to 'master'?
