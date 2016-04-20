From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v5 03/15] index-helper: new daemon for caching index and
 related stuff
Date: Wed, 20 Apr 2016 07:31:08 +0700
Message-ID: <CACsJy8D_4KFjz6HefvzmWw-6Qqg0uguq8MXL6kLY0oMyVhPS0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 02:31:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asg3U-0004b3-HO
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 02:31:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbcDTAbk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 20:31:40 -0400
Received: from mail-lf0-f45.google.com ([209.85.215.45]:33648 "EHLO
	mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751692AbcDTAbk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 20:31:40 -0400
Received: by mail-lf0-f45.google.com with SMTP id e190so31526914lfe.0
        for <git@vger.kernel.org>; Tue, 19 Apr 2016 17:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Xavs3HffqQvzkG717pL6/USwbPCisLl5Z9VJ4V5JZ5Q=;
        b=xeIFwNXxzTLmH0DX01qitSw6FHpk/HaevYszj6WYKxuOsyE+1i2wtXBWARhxbbgQFW
         4/vhD9/w7/SmPxBRh7kcDm8pWnDwNPF9qQMT2Lq++MpcYYGRllO86aezk4wPreCiwJmv
         zIZZGfCGpfeBhy7pdWWa/IX5Tfa51YQvSXnvxBbd+9eMxYcrtuwbb5Rcl1zWI/iEelDl
         lr2tYekwAS12LAuGHU6PUS5bn6dMeGK34audFnEsP4ep14mneuc2D1dRNIfeNORcQH/c
         jk4/Kdirj9aajgw9LjJaUGAQkGOTqwySeQaEKP9BqxNMPl7q2dP321zQ45fEwn5XS0nR
         jqNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Xavs3HffqQvzkG717pL6/USwbPCisLl5Z9VJ4V5JZ5Q=;
        b=Z+aL+EM8ZfigFefvUv5Ivt/gRK/LreTYQsQJTF1NPHTX267nHr2+B66Ao6jyVx8O+S
         /JzDqzTp1+ucrTNkH7yU1vxnEtX+sZt4zZ0l0gFbFAwmCzTeRSHr4LoyFYWmH1VYzXuM
         pD2i3rJB8yYylU86GKyRIwu92VKaNYNj0vZMucyGhoMvXhCZYrLb6BI3TsO99Dce39+5
         hh5VfFWKJwiRNHZBdf9vJmeEZpKouyXDBpkFFpvNPTj2+M2hluC03sCuqR0L8lEBm2+d
         CeW4X7IBDjnl3CMAgPTH44F+kgTax7VOqcqbWce9dTOfAmth7AHeRrm6jPdpGgKTAevy
         jc5Q==
X-Gm-Message-State: AOPr4FWKIZJvgiKfbIo8vZS+ZmvH3qBvQQLbSxh2SLHfiLLKVZsHnVMcsX2lM2kvgkEEfTT0zmuHO/0TgKUtkw==
X-Received: by 10.25.162.198 with SMTP id l189mr2371762lfe.162.1461112298496;
 Tue, 19 Apr 2016 17:31:38 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Tue, 19 Apr 2016 17:31:08 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291973>

On Wed, Apr 20, 2016 at 6:27 AM, David Turner <dturner@twopensource.com> wrote:
> Shared memory is done by storing files in a per-repository temporary
> directory.  This is more portable than shm (which requires
> posix-realtime and has various quirks on OS X).  It might even work on
> Windows, although this has not been tested.

There's another option, but I'm not sure if it's too clever/tricky to
do. Anyway, on *nix we can send file descriptors over unix socket [2],
then mmap them back to access content. On Windows, it looks like
DuplicateHandle [1] can do nearly the same thing. This keeps
everything in memory and we don't have to worry about cleaning up
shm-* files.

[1] http://lackingrhoticity.blogspot.com/2015/05/passing-fds-handles-between-processes.html
[2] http://www.normalesup.org/~george/comp/libancillary/
-- 
Duy
