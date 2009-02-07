From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3] config: Add new option to open an editor.
Date: Sat, 7 Feb 2009 23:50:36 +0200
Message-ID: <94a0d4530902071350h4caab5a8s597ed099d232dde9@mail.gmail.com>
References: <94a0d4530902040741t4333b132v886d7057353ed52a@mail.gmail.com>
	 <1233786856-6571-1-git-send-email-felipe.contreras@gmail.com>
	 <7vmyd1lrnx.fsf@gitster.siamese.dyndns.org>
	 <alpine.DEB.1.00.0902050043000.10279@pacific.mpi-cbg.de>
	 <alpine.DEB.1.00.0902050049240.10279@pacific.mpi-cbg.de>
	 <94a0d4530902071309l7c34945ana2af31e41707fa0c@mail.gmail.com>
	 <alpine.DEB.1.00.0902072214410.10279@pacific.mpi-cbg.de>
	 <94a0d4530902071315o78b2db58n481fbc6e956b5b64@mail.gmail.com>
	 <7vskmque25.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 07 22:52:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVv5q-0000na-8N
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 22:52:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753621AbZBGVuk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 16:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753486AbZBGVuj
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 16:50:39 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:3065 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753458AbZBGVuj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 16:50:39 -0500
Received: by fg-out-1718.google.com with SMTP id 16so802166fgg.17
        for <git@vger.kernel.org>; Sat, 07 Feb 2009 13:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=O8krEqV0Rgg24P6PUR8CrB8uKKTOn5ETetk2xyBO+LE=;
        b=x4H9jJXTDdZtKUD0EwV6ZfI1D80M0w8h6Er1gK7qwUEBtvrmxhR+HsuCX7XgANEtxH
         2hfvjQUurowa/EM5IFOzPQbhbyr0L0b/dmPI+7na3WSMLoIKwcrBT59+jHjDHXEEXwp3
         REok2Vb9mxAWInPHHoqx/D+R1msvR/J5Qtu9w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=L+7H4KMYUMwHaxA3Y0FJiv5q5y59UobVDcbAJWQGYZ4k57ZGoQ0t4/4IatJJkiLN25
         0r+FGJqtW4LCnYgxBVM8QTK2WyCWin9dUNllGFN9JNZugEfnJUXywKwy7vZm7xbIxtsA
         UFMfIX4Wg/SV2bxIZ1tDvJxz4+0W/pk0PjXBU=
Received: by 10.86.95.20 with SMTP id s20mr1846389fgb.40.1234043436932; Sat, 
	07 Feb 2009 13:50:36 -0800 (PST)
In-Reply-To: <7vskmque25.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108890>

On Sat, Feb 7, 2009 at 11:34 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>>>> I think it should, how expensive would it be to call
>>>> git_config(git_default_config, NULL) when it has been loaded already?
>>>
>>> We would not need the complete git_default_config(), would we?
>>
>> Nope, just core.editor. But I don't know how to load only that.
>
> The most expensive part is to actually open and parse the files into
> tokens, not strcmp/prefixcmp the parsed tokens and flipping internal bits
> and storing value in const char * variables.
>
> But you need to be careful about correctness issues.  I do not want
> launch_editor() to run git_config().  The caller, other than the caller
> you happen to be interested in this thread, may already have read the
> config and overrode some of the bits with what was given from the command
> line.  Calling git_config() overwrite the bits and will break these
> callers.
>
> I think the right thing to do is to call git_config() immediately before
> you call launch_editor() in your patch.

Right, also for some reason the caller might actually call a specific
editor and not the one configured, but that would require more changes
to editor.c

For now I guess this patch should be fine (re-sending).

-- 
Felipe Contreras
