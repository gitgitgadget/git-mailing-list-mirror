From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] clone: call transport_set_verbosity before anything else
 on the newly created transport
Date: Mon, 11 May 2015 23:33:49 -0400
Message-ID: <CAPig+cQhLKymUm2GgmFgJ+-i5O=44PJ4yWGpQFvPG_p9xa8R5g@mail.gmail.com>
References: <xmqqfv721rh7.fsf@gitster.dls.corp.google.com>
	<1431400351-1590-1-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Tue May 12 05:34:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ys0xF-0002N4-1I
	for gcvg-git-2@plane.gmane.org; Tue, 12 May 2015 05:34:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752149AbbELDdv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2015 23:33:51 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:36415 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752001AbbELDdu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2015 23:33:50 -0400
Received: by iecmd7 with SMTP id md7so48306553iec.3
        for <git@vger.kernel.org>; Mon, 11 May 2015 20:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=ht7MoZVIBSt/oTrQGQQoNuvYwgIZsVadJF6eipNFRF4=;
        b=lKPc+hSxbfq8F7UkJqNWxjvMvQWLrl5N1OfmZ2HVa+G4EXZCrJmDwKQ9UrIF9tLXOC
         +RYc3A2c9oVRbRAN79lT+mjewpNICla3aWREpkITzIxcnj5cOIu0Ziswb7LhK8XKc1eO
         zKiegXk/hlGYJnQ1wFo5e4EKe1g0UrCTw+RAWNr9MA5IPnVeVo3lz/iZt37bYYs193Q2
         QCAFK5+DphTd8qzz/nhwlLhG0IDvSfIHS7We1+uk1N6bw/7JN4RNTRWj90ZG60/nAvHs
         KO/vjGKThVGChYJGlV950FiAxt0u84sI04UIf5K8ADdOLh/Mu2lPh9g3v3YQUJgpMxPL
         Qq9Q==
X-Received: by 10.107.3.163 with SMTP id e35mr16438573ioi.92.1431401629744;
 Mon, 11 May 2015 20:33:49 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Mon, 11 May 2015 20:33:49 -0700 (PDT)
In-Reply-To: <1431400351-1590-1-git-send-email-mh@glandium.org>
X-Google-Sender-Auth: _1l1CYaxMz-1jL7pH3482wd7PKM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268842>

On Mon, May 11, 2015 at 11:12 PM, Mike Hommey <mh@glandium.org> wrote:
> Commit 2879bc3 made the progress and verbosity options sent to remote helper
> earlier than they previously were. But nothing else after that would send
> updates if the value is changed later on with transport_set_verbosity.
>
> While for fetch and push, transport_set_verbosity is the first thing that
> is done after creating the transport, it was not the case for clone. So
> commit 2879bc3 broke changing progress and verbosity for clone, for urls
> requiring a remote helper only (so, not git:// urls, for instance).
>
> Moving transport_set_verbosity to just after the transport is created
> works around the issue.

Missing sign-off.

> ---
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 53a2e5a..13030ee 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -906,6 +906,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>
>         remote = remote_get(option_origin);
>         transport = transport_get(remote, remote->url[0]);
> +       transport_set_verbosity(transport, option_verbosity, option_progress);
> +
>         path = get_repo_path(remote->url[0], &is_bundle);
>         is_local = option_local != 0 && path && !is_bundle;
>         if (is_local) {
> @@ -932,8 +934,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>         if (option_single_branch)
>                 transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, "1");
>
> -       transport_set_verbosity(transport, option_verbosity, option_progress);
> -
>         if (option_upload_pack)
>                 transport_set_option(transport, TRANS_OPT_UPLOADPACK,
>                                      option_upload_pack);
> --
> 2.4.0.1.gde5e018
