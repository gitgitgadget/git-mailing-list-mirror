From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv1 2/2] git-p4: work with a detached head
Date: Wed, 09 Sep 2015 14:52:13 -0700
Message-ID: <xmqqfv2n5khe.fsf@gitster.mtv.corp.google.com>
References: <1441461738-25066-1-git-send-email-luke@diamand.org>
	<1441461738-25066-3-git-send-email-luke@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Wed Sep 09 23:52:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZnI0-00084L-GK
	for gcvg-git-2@plane.gmane.org; Wed, 09 Sep 2015 23:52:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752202AbbIIVwV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Sep 2015 17:52:21 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:36573 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751870AbbIIVwU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Sep 2015 17:52:20 -0400
Received: by padhk3 with SMTP id hk3so21557823pad.3
        for <git@vger.kernel.org>; Wed, 09 Sep 2015 14:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=YhuEID2vVnqjauujv+c3kN69qHw6FJYsAjwUCdjU2vo=;
        b=p44yBu6UI4+kkB0SuQoWsjrAnJDtEvY1EKPWyN3SW84Nytfyp1UOSRY3Ro4PLnw8ea
         xIuIyvRjJVSREDEgYZiap7iGCGEikEUN28iZrLluoR2SNY9M8bOzUPesX7NkqG/ebTqt
         tspl4gDNvm5zfuxg+yM7nAovdKOAnCUEbMqeISnRnx4lHsyplDI/uxWlGID6ygJPcbJu
         sslbKOQ3iqOXNb6XFZbly/jZ61uNLjfN+p4dcnZ5aYlgIEBRMgaPa9Wfv2ryJWIkl2/b
         8TEF2ctEuckC2X8viv+yMPm4xzapHlpmnGmdYJkYXrDFhS3M8Ujv0YZBFT+ktZZtdm+1
         qy3g==
X-Received: by 10.66.55.66 with SMTP id q2mr65863339pap.94.1441835539582;
        Wed, 09 Sep 2015 14:52:19 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:31c8:2790:408d:8446])
        by smtp.gmail.com with ESMTPSA id gq7sm8109916pac.5.2015.09.09.14.52.18
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Wed, 09 Sep 2015 14:52:18 -0700 (PDT)
In-Reply-To: <1441461738-25066-3-git-send-email-luke@diamand.org> (Luke
	Diamand's message of "Sat, 5 Sep 2015 15:02:18 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277567>

Luke Diamand <luke@diamand.org> writes:

>      def run(self, args):
>          if len(args) == 0:
>              self.master = currentGitBranch()
> -            if len(self.master) == 0 or not gitBranchExists("refs/heads/%s" % self.master):
> -                die("Detecting current git branch failed!")
> +            if self.master == "undefined":
> +                self.master = None

The comparison with textual "undefined" smelled fishy and I ended up
looking at the implementation of currentGitBranch().

    def currentGitBranch():
        return read_pipe("git name-rev HEAD").split(" ")[1].strip()

Yuck.  I know it is not entirely the fault of this patch, but
shouldn't it be reading from

    $ git symbolic-ref HEAD

and catch the error "fatal: ref HEAD is not a symbolic ref" and use
it as a signal to tell that the HEAD is detached?
