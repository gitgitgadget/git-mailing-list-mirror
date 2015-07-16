From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] gitk: Add a "Copy commit summary" command
Date: Thu, 16 Jul 2015 10:02:41 -0700
Message-ID: <xmqq380o593i.fsf@gitster.dls.corp.google.com>
References: <1437060565-4716-1-git-send-email-dev+git@drbeat.li>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Paul Mackerras <paulus@samba.org>
To: Beat Bolli <dev+git@drbeat.li>
X-From: git-owner@vger.kernel.org Thu Jul 16 19:02:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZFmYb-0000Sd-2D
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jul 2015 19:02:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751769AbbGPRCp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2015 13:02:45 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:36347 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751434AbbGPRCo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2015 13:02:44 -0400
Received: by igbij6 with SMTP id ij6so18702326igb.1
        for <git@vger.kernel.org>; Thu, 16 Jul 2015 10:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=lvhxH9aYa3xTEbjy8IkVRmSL3VIduj0PdFnBZx8rYHw=;
        b=J8RXfzlXs//q64qWk0DNvRJ5TCkSRTNt4tqVWMvEsFoiYuBCNOPZKPhe8oAFA4GgEY
         rTIrAYQmv4er5JUJfwJyOdCKdTcd//21qxPfrVXqYWTV0uVP+bejzblu6fJmGM4JC+ZE
         heT/bTk14GDkGoK7oOEi0lEg6wRQgf9ieI+C0EOjwlnMXp+S4pVODcq4OrMiZaYASdF8
         p3ZiCSqRYHqJL8/JYQrPduy4vMynokvVn1fME+0Fj4235gdSeqmEGHeOH/OvPXa7NQUo
         BW1CVp3e/FW26mNgXq/NW5hxHlGU0h33fN0Z1Y1iy4DL2mszGHPKXzVNxC7DoSIx1pjQ
         8cxw==
X-Received: by 10.50.136.194 with SMTP id qc2mr5931417igb.6.1437066163703;
        Thu, 16 Jul 2015 10:02:43 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:117b:74b0:a5d4:7d4c])
        by smtp.gmail.com with ESMTPSA id q10sm1691110ige.16.2015.07.16.10.02.42
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 16 Jul 2015 10:02:42 -0700 (PDT)
In-Reply-To: <1437060565-4716-1-git-send-email-dev+git@drbeat.li> (Beat
	Bolli's message of "Thu, 16 Jul 2015 17:29:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274033>

Beat Bolli <dev+git@drbeat.li> writes:

> When referring to earlier commits in commit messages or other text, one
> of the established formats is
>
>     <abbrev-sha> ("<summary>", <author-date>)
> ...
> +proc copysummary {} {
> +    global rowmenuid commitinfo
> +
> +    set id [string range $rowmenuid 0 7]
> +    set info $commitinfo($rowmenuid)
> +    set commit [lindex $info 0]

7 hexdigits is not always an appropriate value for all projects.
The minimum necessary to guarantee uniqueness varies on project, and
it is not a good idea to hardcode such a small value.  Not-so-old
Linux kernel history seems to use at least 12, for example.

I believe that the "one of the established formats" comes from a
"git one" alias I published somewhere long time ago, that did
something like this:

  git show -s --abbrev=8 --pretty='format:%h (%s, %ai' "$@" |
  sed -e 's/ [012][0-9]:[0-5][0-9]:[0-5][0-9] [-+][0-9][0-9][0-9][0-9]$/)/'

where the combination of --abbrev=8 and format:%h asks for a unique
abbreviation that is at least 8 hexdigits long but can use more than
8 if it is not long enough to uniquely identify the given commit.

I do not offhand know how $commitinfo is populated, but perhaps you
can tweak that code to ask for both %H (for the full commit object
ID) and %h (for the unique abbreviation of appropriate length) and
store the value for %h to a new field in the $commitinfo($rowmenuid)
array, so that you do not have to have such a hard-coded truncation
here?

> +    set date [formatdate [lindex $info 2]]
> +    set summary "$id (\"$commit\", $date)"
> +
> +    clipboard clear
> +    clipboard append $summary
> +}
> +
>  proc writecommit {} {
>      global rowmenuid wrcomtop commitinfo wrcomcmd NS
