From: Timur Tabi <timur@freescale.com>
Subject: Re: How can I tell if a file has been updated upstream?
Date: Thu, 25 Feb 2010 18:18:51 -0600
Message-ID: <ed82fe3e1002251618g750764bm82b0653770554dcf@mail.gmail.com>
References: <ed82fe3e1002050823gec57827j184c9c4cff4f4a45@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 26 01:19:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NknvZ-0007px-5D
	for gcvg-git-2@lo.gmane.org; Fri, 26 Feb 2010 01:19:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934748Ab0BZATR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2010 19:19:17 -0500
Received: from mail-fx0-f219.google.com ([209.85.220.219]:63764 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934701Ab0BZATN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2010 19:19:13 -0500
Received: by fxm19 with SMTP id 19so6907990fxm.21
        for <git@vger.kernel.org>; Thu, 25 Feb 2010 16:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:from:date:x-google-sender-auth:message-id:subject:to
         :content-type;
        bh=3yOTSzq8KotGlqRodwgarazJEvikKA8VEObvKc6xj9s=;
        b=v4fOwbY8rpZqi1elY+Z7Nggz13Rx4tUvSSB8Labk2Jc5TNz8/+ZHj8IZrYYDWA8pBU
         x2FHLEBjKd1OM2r6MkAIf+Grqe7ZrVOK0rou/3Ri6VUEJkAwUWi6l9Ff0hoI/SjwYZaR
         01kTY7q4lb+nMU/Lz77aN5M9n6+MomlCFVnuo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:content-type;
        b=svo4G+0OZRFXlFSUg+ul8YA9yYF8RsVYcZMUCh51c8HE1QOOU0QAvP//qxXwXf/+Dh
         uBqyo8M+HPJKNynx6uJY0O8QDmf1gzCW5ndAmJyOJ7abcFh4dND36+wepuFWHwutpxPZ
         Qld58b9NWa5ItUN0rj/VuoBcGsOHPqCRnsrlI=
Received: by 10.239.190.19 with SMTP id v19mr33999hbh.171.1267143551109; Thu, 
	25 Feb 2010 16:19:11 -0800 (PST)
In-Reply-To: <ed82fe3e1002050823gec57827j184c9c4cff4f4a45@mail.gmail.com>
X-Google-Sender-Auth: f5f7d714a7ebbaae
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141084>

On Fri, Feb 5, 2010 at 10:23 AM, Timur Tabi <timur@freescale.com> wrote:
> Is there a way for me to tell if a particular file in my repository
> has an update in the upstream repository?

Thanks to everyone who replied.  Here's what I came up with:

def check_for_updates():
    # Get the path to our script.  This should be a git repository.
    script_path = os.path.dirname(os.path.realpath(__file__))

    # Determine the upstream URL
    p = subprocess.Popen(['git', 'config', '-f', script_path + '/.git/config',
        '--get', 'remote.origin.url'],
        shell=False, stdout=subprocess.PIPE, stderr=open(os.devnull, 'w'))
    url = p.communicate()[0].strip()
    if not url:
        # The script is not running from a git repository
        return

    # Determine the HEAD of the upstream repository
    p = subprocess.Popen(['git', 'ls-remote', url, 'HEAD'],
        shell=False, stdout=subprocess.PIPE, stderr=open(os.devnull, 'w'))
    sha = p.communicate()[0].split()
    if not sha:
        # Something is wrong with the upstream repository
        return
    sha = sha[0] # The SHA of the upstream head

    # Check if the remote SHA is in the local repository.
    # git --git-dir=/home/b04825/bin/.git show-ref HEAD
    p = subprocess.Popen(['git', '--git-dir=' + script_path + '/.git',
        'log', '-1', sha],
        shell=False, stdout=subprocess.PIPE, stderr=open(os.devnull, 'w'))
    if not p.communicate()[0]:
        # If we can't find the SHA locally, then it means that the local
        # repository is out of date.  We pretend that it means that this script
        # is out of date.
        print 'There is an update for this script available.  Please
pull from the remote'
        print 'repository (e.g. "cd %s; git pull")' % script_path

-- 
Timur Tabi
Linux kernel developer at Freescale
