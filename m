From: "Ray Chuan" <rctay89@gmail.com>
Subject: [git/perl/cygwin] Permission denied at /usr/bin/git-svn line 2339
Date: Mon, 4 Aug 2008 13:16:16 +0800
Message-ID: <be6fef0d0808032216r3d965562u447d435ca99c18c7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 04 07:17:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPsRs-0006gV-Us
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 07:17:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752257AbYHDFQT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 01:16:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751919AbYHDFQT
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 01:16:19 -0400
Received: from ti-out-0910.google.com ([209.85.142.184]:10379 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751756AbYHDFQT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 01:16:19 -0400
Received: by ti-out-0910.google.com with SMTP id b6so468365tic.23
        for <git@vger.kernel.org>; Sun, 03 Aug 2008 22:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=p856FuhL9x5eJ4FwVIyYSeURZffWltW/GLiPSF6PMlM=;
        b=X6/DOH5hHVlUaf3lDe72Pb+jLuSNiiFR0oSPcYUcE0wjJwtryNsZQ7EfXLWxVwXAD2
         d9UdKnYqYtKskYnfFlzDOK3apjQqflPc2L/RsWVgI+sWUpUhcXnXjnTPGkBy8ypGyXXE
         zJQItOZYUBOIEqHORBYW8V4r6ie27BrNMGZa4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=bNTDd7RJ5LMk+PgtCuImhaKxDzAM4Ibb+pr9xLlQ+H+OlCplIpsMW/Q+/89h5FnBgx
         Y5H3ncFXNlHQ8t/BOjLrjBDHjNtvzL3IuVO1YOhMcXGLuKRdkB5A/OF9sSV0GxXOaKpF
         jENCWzVz8d1eM1ZsgdqEem6soTd2Ae9Zm8Wio=
Received: by 10.110.11.1 with SMTP id 1mr9101038tik.2.1217826976906;
        Sun, 03 Aug 2008 22:16:16 -0700 (PDT)
Received: by 10.110.37.4 with HTTP; Sun, 3 Aug 2008 22:16:16 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91315>

Hi,

i'm encountering an issue with git-svn running on cygwin (not sure if
this is exclusive to cygwin) when migrating data from svn to git.

$ git-svn clone file:///F:/test/svn-native-repo/
Initialized empty Git repository in /cygdrive/F/test/git/svn-native-repo/.git/
       A       sitemap.html
       A       funcs.js
       A       index.html
       A       styles.css
r1 = d112a5b470fd4387c7bbb7199d0d7a065754b127 (git-svn)
Permission denied: Can't open
'/cygdrive/c/DOCUME~1/myself/LOCALS~1/Temp/report.tmp': Permission
denied at /usr/bin/git-svn line 2339


the repo used was a dummy subversion repo with 2 revisions: an add,
and a modification commit. (dump file here [1])

i suspect this is caused by locks over files. using perl -d:

$ perl -d /usr/bin/git-svn clone file:///F:/test/svn-native-repo/
c 3995
c 3995
c 3838
s
c 85

SVN::Ra::AUTOLOAD(/usr/lib/perl5/vendor_perl/5.10/i686-cygwin/SVN/Ra.pm:85):
85:         my @ret = $func->($self->{session}, @_);

immediately after this line the error is generated.

a fix would be to issue closes to the processes, as in
Git::_close_hash_and_insert_object and Git::_close_cat_blob:

767a768
>       $self->_close_hash_and_insert_object();
856a858
>       $self->_close_cat_blob();

(Note: currently this doesn't fix the issue too, cos the methods do
not do their job properly (on my side, at least): see

http://article.gmane.org/gmane.comp.version-control.git/91314
)

my environment is:
- win xp home sp2
- Cygwin: 1.5.25-15 (latest)
- Git: 1.5.6.4-1 (latest)
- subversion-perl: 1.4.6-3 (latest)
- Perl: 5.10.0-5 (latest)

[1] http://thelilaeanbellis.com/shared/svn-native-repo.dump
