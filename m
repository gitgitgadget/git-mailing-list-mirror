From: Josh McCullough <joshua.mccullough@gmail.com>
Subject: Ignore updates to files which are ignored, even if they're indexed.
Date: Tue, 17 May 2016 21:07:16 -0400
Message-ID: <CAK-5vhzvuwteJgWSkAhAAFf9-L4FSs2o58yNF5rQQrrE231d3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 18 03:07:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2pxL-0005Lk-KC
	for gcvg-git-2@plane.gmane.org; Wed, 18 May 2016 03:07:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752167AbcERBHT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2016 21:07:19 -0400
Received: from mail-vk0-f42.google.com ([209.85.213.42]:32918 "EHLO
	mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751842AbcERBHS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2016 21:07:18 -0400
Received: by mail-vk0-f42.google.com with SMTP id z184so42513661vkg.0
        for <git@vger.kernel.org>; Tue, 17 May 2016 18:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to;
        bh=+tsQsj75/huJX1uJ31IcyKU3yb8w2EDTuGbctx4k6UA=;
        b=KNvPwZUQXDFxuOe8XVFFmzp4SNkgQyP4EntJ+MY+iVr57oC4dU4hiz+PyMDIR33vFq
         2IoBl/tETH5Z99SAjsPNf8vKWY2hrwFaWwxpyIiX763trNGHLq9jKudatclHZEq67YjL
         4L7DrDrRo817qzem3nKA/pB7+SD/ffwMPV+aHTEMPp1kdNXE78U8mavOh2VT406C21ZA
         eHG1L+Wh2dIp6pvs8A7x55zPYDAUWHJBoSL2X4/2NX7w80QsbJBTC/hpP3TKFLIlX5EP
         Vz/kwTIfCUVUPZp0/2PZ4lXCmidw7035qmf2tdWANt7NK53jDz5/UDF/4j8rv55yuJM6
         HhRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=+tsQsj75/huJX1uJ31IcyKU3yb8w2EDTuGbctx4k6UA=;
        b=MbaMojRsnJ19Tcq+TO0+oXKmQ/pL37D36j2YAd4CcieuwO7C+laz6aUr0jOPayMUFs
         w6UIxDCRF5B1jO2jeCbw5lr4AbDmsaejCVLY8PQE1elJbT34Evqxsz7FFXkS2WsyT2qn
         XrgkPsQI5OcDtW+JNn+S3txeVycNNZ3SbmGoFgzw72qGtcmhHcqO1k+uv8IRaVH7mx17
         4nLizo906FSsEf020eMBamXRBZcL8ED5vlcCo4H4a6yJEEoxFzOygX42+R0ZF3HVwg+J
         gUjUjY+kV3qaQoEqYc8EM7w9LzLXWQAci6fg3zB8qsw3YGqvxsQOmurcfwzwlAKIbuPB
         mCYQ==
X-Gm-Message-State: AOPr4FUea2vvsydgujc5dRGMIGs+dyUmTCXQql3rK/qCw+IGICpaQROwaQtNAvb9eKbNdunWgeg684x8Vu7c/w==
X-Received: by 10.31.190.139 with SMTP id o133mr2240931vkf.154.1463533636820;
 Tue, 17 May 2016 18:07:16 -0700 (PDT)
Received: by 10.31.216.193 with HTTP; Tue, 17 May 2016 18:07:16 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294927>

TL;DR: Git should ignore files if they are in `.gitignore`, regardless
of whether or not the file has changed (or been removed).

Use Case

An initial set of "local" config files are committed to a repo. Each
developer will pull down this set of files, but changes will be
auto-ignored unless the file is force-added after a change is made.

Current Workarounds

1) Use `git update-index --assume-unchanged local-config.xyz` to
ignore local changes to the file.
2) Add templates instead (local-config.template.xyz) and tell each
developer to copy these templates and remove the ".template" portion
of the file name. The file name without the ".template" portion is
added to `.gitignore`.

The current workarounds rely on the developer to know/remember what to
do. It would be nice if we could do this instead:

1) Create the initial `config-local.xyz`.
2) Add the new file to the index (`git add`).
3) Add the same path to `.gitignore`, and add the changes to the index.
4) Commit the staged changes.
5) Edit the `config-local.xyz` file.
6) Run `git status` -- git will not suggest that the file was changed
since it is in the `.gitignore`. If 7) The user specifically made
changes they wish to commit, the can force-add the ignored file.

Doing a search for [git commit file only once then ignore changes]
will show that other people wish for the same feature.


Thanks!


----- ----- -----

Side note: It took me 4 tries to get this email to go through, since
non-plain-text messages are strictly forbidden by this mailing list. I
use Inbox, which doesn't have an option to ensure a message is sent as
plain text. I had to switch back to GMail to get it to go through.
