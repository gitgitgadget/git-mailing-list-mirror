From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Question: .idx without .pack causes performance issues?
Date: Mon, 03 Aug 2015 18:27:27 -0700
Message-ID: <xmqqk2tb6dxc.fsf@gitster.dls.corp.google.com>
References: <CAEtYS8QWCg5_DtrJw-e+c50vcG0OpciR6LWon-3GgyngGn+0pQ@mail.gmail.com>
	<xmqq4mkxwd77.fsf@gitster.dls.corp.google.com>
	<xmqqzj2puxu2.fsf@gitster.dls.corp.google.com>
	<xmqqtwsxtey8.fsf@gitster.dls.corp.google.com>
	<CAEtYS8QEuEA6d13FH_0_ZbT9YbJ_UdvhkSBYq1xyGCAuznh-GQ@mail.gmail.com>
	<CAEtYS8SNksc0m5rn_tRk8bGLBeq_8QcBLHyHo=cOfZ+aE6n0gA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: Doug Kelly <dougk.ff7@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 04 03:27:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMR0y-0002av-1f
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 03:27:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751470AbbHDB1a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2015 21:27:30 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35995 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751078AbbHDB13 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2015 21:27:29 -0400
Received: by pacgq8 with SMTP id gq8so37327987pac.3
        for <git@vger.kernel.org>; Mon, 03 Aug 2015 18:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=vdLtXQs46Is0ttuzt9V7oQQaXx0CTgR5hG5AeXfyz0s=;
        b=mvkNybv+JDf2AuAPQOIQo91e3TEb7pihTxxbAyzyxBP/0CveLui0BrjR4XAVG+gdoF
         /aSS+139dd8tXt0rbMvHyLEea9V4waLiW9nvUdHYdnhE6bUjUcFTqK8ZEsAkY5YEl/va
         aGVa4++EFw1/14cyyM/2APdw/vb/ZiVJKXUZ+gLRDZTgAN1lV593WGP5xQsbILQc8aD6
         NKRG84ZzdVlvgiZ2rziEG1kBaAD6SO8ts0uliLDz3SIvXiezK8uOJB5XaJnxuyC5bRUQ
         Mc/nFF2lOdEUHw1X7AF5ZQyzQqpaQZ2oaUz9sHFQ2qildxcj+Gua4Kgi4pE/EBwDTu5u
         frJQ==
X-Received: by 10.68.178.35 with SMTP id cv3mr1946168pbc.141.1438651648925;
        Mon, 03 Aug 2015 18:27:28 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:38a2:7ad5:137e:6e11])
        by smtp.gmail.com with ESMTPSA id hb1sm9238691pbd.36.2015.08.03.18.27.28
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 03 Aug 2015 18:27:28 -0700 (PDT)
In-Reply-To: <CAEtYS8SNksc0m5rn_tRk8bGLBeq_8QcBLHyHo=cOfZ+aE6n0gA@mail.gmail.com>
	(Doug Kelly's message of "Mon, 3 Aug 2015 17:17:28 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275236>

Doug Kelly <dougk.ff7@gmail.com> writes:

> Here's a change to prune.c that at least addresses the issue by removing
> .idx files without an associated pack, but it's by no means pretty.  If anyone
> has any feedback before I turn this into a formal patch, it's more than welcome!

I'd hesitate to see removal of a file (for that matter, a creation
too) inside a "while (de = readdir)" loop.  As the original function
is about temporary files, and the new thing is not about temporary
files at all, I'd further prefer that we do not do it in the same
loop.

I am wondering if we can add a new mode to report_pack_garbage() in
sha1_file.c to allow it to remove stale and lone ".idx".  Most of
the time we are accessing packs read-only, and I do not want the
function to unconditionally remove lone ".idx", but perhaps we
can teach "prune" to set a custom report_garbage() routine and
react to a call to its custom report_garbage()?

Perhaps that custom report_garbage() can make a list of ".idx"
files, iterate over it to pick the lone one without ".pack" and
remove them.  Or the custom report_garbage() can make a list of lone
".idx" files, if you tweak the interface to report_garbage() to
contain th seen_bits value, avoiding the need to check the existence
of ".pack" for the second time.
