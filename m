From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6] git-p4: Obey core.ignorecase when using P4 client specs.
Date: Wed, 26 Aug 2015 14:48:18 -0700
Message-ID: <xmqqsi75202l.fsf@gitster.dls.corp.google.com>
References: <1440605295-73844-1-git-send-email-larsxschneider@gmail.com>
	<xmqqa8td3je7.fsf@gitster.dls.corp.google.com>
	<4CB47914-F04C-4E88-8D73-E00AFEFEF727@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 26 23:48:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUiYT-0002uz-5D
	for gcvg-git-2@plane.gmane.org; Wed, 26 Aug 2015 23:48:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752864AbbHZVsV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Aug 2015 17:48:21 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34691 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752692AbbHZVsU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2015 17:48:20 -0400
Received: by pabzx8 with SMTP id zx8so712563pab.1
        for <git@vger.kernel.org>; Wed, 26 Aug 2015 14:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=obML31zREZ8IONm0LCx5I4ZbVWcHPvvC+KSbybZ8GYA=;
        b=pslNeFZmfj0U3fRActm8tXU/fG/SVhFlnUcX8eOTNuvKQuGQQTHj3ugJwv4zb7TFDW
         67E3dP+5AwYsl7ZzcFoX0dkYSHHmmfF3wtcV/QR6EiS2k+40ChZHdT00cmqs5juOa5Q2
         nm3zfIiryc9ssEitXaToP/vn5ouiIf/OvtgZt/XEd8UNJwdAczkPL9CEEbn/IDefQd4k
         ycmZ75LLoTR9Bwqc34TOhAHuLIrWCysHVrCewR850zvSzEBCu6u+ff3kCvrOYCe5w22X
         gDVNZC0+YShY157wm/xXyDDZ0ArpfaTijheG/78xvtL4JvrDjA93gH8N98So21kFaDI3
         Yvxw==
X-Received: by 10.68.229.195 with SMTP id ss3mr1371440pbc.100.1440625699732;
        Wed, 26 Aug 2015 14:48:19 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:ac9b:ef8c:b4db:d257])
        by smtp.gmail.com with ESMTPSA id sk5sm7073pbc.75.2015.08.26.14.48.18
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Wed, 26 Aug 2015 14:48:18 -0700 (PDT)
In-Reply-To: <4CB47914-F04C-4E88-8D73-E00AFEFEF727@gmail.com> (Lars
	Schneider's message of "Wed, 26 Aug 2015 23:25:47 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276642>

Lars Schneider <larsxschneider@gmail.com> writes:

> On 26 Aug 2015, at 22:05, Junio C Hamano <gitster@pobox.com> wrote:
>
>> larsxschneider@gmail.com writes:
>>=20
>>> From: Lars Schneider <larsxschneider@gmail.com>
>>>=20
>>> We run P4 servers on Linux and P4 clients on Windows. For an unknow=
n
>>> reason the file path for a number of files in P4 does not match the
>>> directory path with respect to case sensitivity.
>>=20
>> Thanks, but is this still "For an unknown reason", or during the
>> course of debugging you found the root cause, which is what led to
>> this fix?
> We are migrating away from P4 and therefore I haven=E2=80=99t debugge=
d the
> root cause. The source of this problem is 100% P4 related. No Git
> involvement at all. Maybe I just remove this paragraph?

Perhaps.  If it is irrelevant how the P4 depot ended up recording
the paths in mixed cases, then we can just say that as a prerequiste
condition to trigger the problem.

Perhaps rephrase the entire thing like this?

    Perforce depot may record paths in mixed cases, e.g. "p4 files" may
    show that there are these two paths:

        //depot/path/to/file1
        //depot/pATH/to/file2

    and with "p4" or "p4v", these end up in the same directory, e.g.

        //depot/path/to/file1
        //depot/path/to/file2

    which is the desired outcome on case insensitive systems.

    If git-p4 is used with client spec "//depot/path/...", however, the=
n
    all files not matching the case in the client spec are ignored (in
    the example above "//depot/pATH/to/file2").

    Fix this by downcasing the depot_path when core.ignorcase is set to
    true.

Thanks.
