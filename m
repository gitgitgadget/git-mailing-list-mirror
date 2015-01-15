From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Advise on a push only repo
Date: Thu, 15 Jan 2015 11:31:00 -0800
Message-ID: <xmqqa91j7sej.fsf@gitster.dls.corp.google.com>
References: <9782FD24F9FA45659CCE5171E73E49E7@black>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: "Jason Pyeron" <jpyeron@pdinc.us>
X-From: git-owner@vger.kernel.org Thu Jan 15 20:31:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBq8M-000889-9e
	for gcvg-git-2@plane.gmane.org; Thu, 15 Jan 2015 20:31:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752917AbbAOTbE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2015 14:31:04 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58336 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751423AbbAOTbC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2015 14:31:02 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1756A2E74B;
	Thu, 15 Jan 2015 14:31:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LnbYfuiP+ZZB8k4hrLkltBeM7Qc=; b=vpZUZe
	HZwzTzBP4D1K9eLMki+6BjkiivJbNrMdZtCN3iU8mVCvZVV2qGqIWYnUsX1NmAty
	i4fealBVK1XC40+LFsxKkFnTWONuausrEgMRlDx5p6qLh0EKl2+Z9hIvXhGe/8k9
	HT1ZrJRmEnv1b4vraUxUfztc4vBhHDmHIEt7k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ea1TORIteBzkGx62TOg64aDy0DFdWYKs
	gpcP+VtId0+sqZTHvF2A8pI6IfgrDWz/fbbpwoQXbXcLVoCsHDQgYFHIl+uEPtHR
	t28qrdDTDs0G8YL84CNWxL8OUP5O8GyEwlIiGZKOhxWbCc5JoS2S9vgQUwMerx02
	1+e4xIhDoqE=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F3D632E748;
	Thu, 15 Jan 2015 14:31:01 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 794AE2E747;
	Thu, 15 Jan 2015 14:31:01 -0500 (EST)
In-Reply-To: <9782FD24F9FA45659CCE5171E73E49E7@black> (Jason Pyeron's message
	of "Thu, 15 Jan 2015 13:02:19 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 09E3D5C2-9CED-11E4-9214-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262504>

"Jason Pyeron" <jpyeron@pdinc.us> writes:

> I am setting up a continous integration (CI) system for an open source
> project and I want to allow forking developers to use the system, but
> I do not want anyone to do a clone or fetch from the CI git repo, the
> repo.
>
> Any advice on limiting the https smart protocol to push only, blocking clone and fetch?
>
> Looking at http-backend.c
>    542  static struct service_cmd {
> ...
>    558  };

Looking at http-backend.c

     19 struct rpc_service {
     20         const char *name;
     21         const char *config_name;
     22         signed enabled : 2;
     23 };
     24 
     25 static struct rpc_service rpc_service[] = {
     26         { "upload-pack", "uploadpack", 1 },
     27         { "receive-pack", "receivepack", -1 },
     28 };

So it would be natural to assume that there must be a way to
enable/disable these two services, no?

Looking at http_config() there, I would guess perhaps:

    [http]
        uploadpack = false
        getanyfile = false

but I am not sure if the latter is needed (or anybody seriously
tested it, for that matter).
