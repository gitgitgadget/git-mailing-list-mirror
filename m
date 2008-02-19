From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: [PATCH] branch: optionally setup branch.*.merge from upstream local branches
Date: Tue, 19 Feb 2008 08:59:22 -0500
Message-ID: <76718490802190559m3f5def8ej667d4d4a1ae8e6c7@mail.gmail.com>
References: <1203386832-43969-1-git-send-email-jaysoffian@gmail.com>
	 <76718490802181819o4cf742edi92bbcd9039f0cdac@mail.gmail.com>
	 <alpine.LSU.1.00.0802191054070.30505@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 19 15:00:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRT11-0007LT-OS
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 15:00:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753384AbYBSN7Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 08:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752244AbYBSN7Y
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 08:59:24 -0500
Received: from wa-out-1112.google.com ([209.85.146.177]:56487 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753384AbYBSN7W (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 08:59:22 -0500
Received: by wa-out-1112.google.com with SMTP id v27so3490836wah.23
        for <git@vger.kernel.org>; Tue, 19 Feb 2008 05:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ttQnCRgRW/lfRCBVTJqy3yKKOz2lo4wNiXpHnppFRIA=;
        b=iyrWSksLEg0ifAYjmyl/8tUjjcyqZIlkuIMAQGcrRxpBXAuVOsysJADmIxpcXAnbWEKvUmi0+Rc/vTr9Vf5rI0Nj8ZPoRubeZ5GcJaq/q5hOaVZE4+1EYMyT6dLsLSymCIXkLUVotT6iF+VAsWjgyyQeJ8vhyktKlRCEQFknDyY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=f+aa/gauZydTZ886pUGFKPzjwf2I3DogpdMObjcdPRtl5L80NxKCHlJUe/MH83Y2OiWHKXxQaWouphp5nZSgOctgr/AIJlRQtsTsKOrqqI3Pa854D2+RxCRTmlYB1kbsSkl4W3+b6Tua25ziCLcijdB2TP2O7lMg1s1CmulhXXE=
Received: by 10.114.161.11 with SMTP id j11mr4612570wae.127.1203429562437;
        Tue, 19 Feb 2008 05:59:22 -0800 (PST)
Received: by 10.114.145.13 with HTTP; Tue, 19 Feb 2008 05:59:22 -0800 (PST)
In-Reply-To: <alpine.LSU.1.00.0802191054070.30505@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74407>

On Feb 19, 2008 5:55 AM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> Ah, yes.  But I still maintain that xstrdup()ing orig_ref only to free it
> later is ugly.  Why not have the "tracking.src ? tracking.src : orig_ref"
> as I suggested?  The free() obviously can stay, since it will say
> "free(NULL)" in the case of tracking.matches == 0.

How about this?

static int setup_tracking(const char *new_ref, const char *orig_ref,
                          enum branch_track track)
{
	char key[1024];
	struct tracking tracking;

	if (strlen(new_ref) > 1024 - 7 - 7 - 1)
		return error("Tracking not set up: name too long: %s",
				new_ref);

	memset(&tracking, 0, sizeof(tracking));
	tracking.spec.dst = (char *)orig_ref;
	if (for_each_remote(find_tracked_branch, &tracking))
		return 1;

	if (!tracking.matches && track != BRANCH_TRACK_ALWAYS)
		return 1;

	if (tracking.matches > 1)
		return error("Not tracking: ambiguous information for ref %s",
				orig_ref);

	sprintf(key, "branch.%s.remote", new_ref);
	git_config_set(key, tracking.remote ?  tracking.remote : ".");
	sprintf(key, "branch.%s.merge", new_ref);
	git_config_set(key, tracking.src ? tracking.src : orig_ref);
	free(tracking.src);
	printf("Branch %s set up to track %s branch %s.\n", new_ref,
		tracking.remote ? "remote" : "local", orig_ref);

	return 0;
}

j.
