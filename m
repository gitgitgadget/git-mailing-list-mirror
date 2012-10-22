From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] transport-helper: check when helpers fail
Date: Mon, 22 Oct 2012 21:35:00 +0200
Message-ID: <CAMP44s2HRHjoohFOdLT1F6cbGhknmaT3Z5tFfp1gpokoGMxCdQ@mail.gmail.com>
References: <1350847158-14154-1-git-send-email-felipe.contreras@gmail.com>
	<5084E931.3010809@viscovery.net>
	<CAMP44s2XDkLhKkqvxnGH+U5X=42dXU1550xVQvyQk=WD2p0c6Q@mail.gmail.com>
	<50854E20.1040303@viscovery.net>
	<CAMP44s1m9eVqqrgJFuWOBa3DCZAzAqpVwG8Nxn-6MbXWbF_2fw@mail.gmail.com>
	<CAMP44s27oPMu8Goded-Tcw9_fmgRux3yiNvu0FBPUxHOdp1Zgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Oct 22 21:35:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQNmO-00058l-R8
	for gcvg-git-2@plane.gmane.org; Mon, 22 Oct 2012 21:35:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752145Ab2JVTfB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2012 15:35:01 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:52549 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751059Ab2JVTfA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2012 15:35:00 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so2828055oag.19
        for <git@vger.kernel.org>; Mon, 22 Oct 2012 12:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=N5kRloNVutkrAukGFdee9wJCcwHSaaHxACVC8wrsGnM=;
        b=NxAWRUzaCt7tDR4FGTByQWxBmuvzXPIor9JrwOE1HNVbOxeKWQ+e1fTQJ8CyTTEgRv
         ETTVnYcmWitAEoerzTCdT+XFXTCQaJ29o2lJPnhrBoqYlnD84P36L8mjMhUQiedoJxQC
         oK6RMvDjiiW46NYTYd53hEiDZRn1fvyWoeT6GhALfciJjDtJ0zVT9ZmxgqCnBGv1Q+Ux
         np5feGOhUj3AxIAYjIx79WxFEg7O14B8cZwiWtfE8zCbitycoJ0axv3g93VfVJvlHoNN
         eTjMW36yiU4mN8uK1gSe66KIheXyoypkCtd/UUhY3p2DW7mC0CdcosqpzK3jZk+Nstei
         4zQQ==
Received: by 10.182.235.46 with SMTP id uj14mr2435381obc.40.1350934500109;
 Mon, 22 Oct 2012 12:35:00 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Mon, 22 Oct 2012 12:35:00 -0700 (PDT)
In-Reply-To: <CAMP44s27oPMu8Goded-Tcw9_fmgRux3yiNvu0FBPUxHOdp1Zgw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208200>

On Mon, Oct 22, 2012 at 7:12 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Mon, Oct 22, 2012 at 4:31 PM, Felipe Contreras

> I've tried everything, and yet a SIGPIPE is detected only with
> remote-testgit, not with my code, and they both exit the same way, and
> at the same time, and fast-export exits the main function (apparently
> a process can finish with SIGPIPE after main?)
>
> I have no idea what's going on, so I don't know if we need any extra
> code in transport-helper at all.
>
> Any ideas?

Must be a timing issue:

sh -c 'echo hello' | sh -c 'exit 1' -> no signal
sh -c 'echo hello' | /usr/bin/false -> SIGPIPE

I can trigger it by adding an extra delay:

This works:

test_expect_success 'proper failure checks for pushing 1' '
	export GIT_REMOTE_TESTGIT_FAILURE=1 &&
	(cd localclone && ! git push --all) 2> errors &&
	grep -q "Error while running fast-export" errors
'

This doesn't:

test_expect_success 'proper failure checks for pushing 2' '
	export GIT_REMOTE_TESTGIT_FAILURE=1 &&
	export GIT_REMOTE_TESTGIT_SLEEPY=1 &&
	(cd localclone && ! git push --all) 2> errors &&
	grep -q "Error while running fast-export" errors
'

This does:

test_expect_success 'proper failure checks for pushing 3' '
	export GIT_REMOTE_TESTGIT_FAILURE=1 &&
	export GIT_REMOTE_TESTGIT_SLEEPY=1 &&
	(cd localclone && ! git push --all) 2> errors &&
	grep -q "Told to fail" errors
'

So, depending on your luck, transport-helper might or might display an
error, it will exit at the right place nonetheless, because of:

	if (strbuf_getline(buffer, helper, '\n') == EOF) {
		if (debug)
			fprintf(stderr, "Debug: Remote helper quit.\n");
		exit(128);
	}

Not ideal, but I guess it's not a big deal.

Cheers.

-- 
Felipe Contreras
