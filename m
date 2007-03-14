From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: git protocol over port-forwarding
Date: Thu, 15 Mar 2007 10:07:27 +1300
Message-ID: <46a038f90703141407k6302cc87w27691980a65e96b5@mail.gmail.com>
References: <17912.16608.852664.321837@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Bill Lear" <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Wed Mar 14 22:07:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRah1-00080m-Qr
	for gcvg-git@gmane.org; Wed, 14 Mar 2007 22:07:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422654AbXCNVH3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 17:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422657AbXCNVH3
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 17:07:29 -0400
Received: from wx-out-0506.google.com ([66.249.82.234]:42061 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422654AbXCNVH2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 17:07:28 -0400
Received: by wx-out-0506.google.com with SMTP id h31so327530wxd
        for <git@vger.kernel.org>; Wed, 14 Mar 2007 14:07:27 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ORkNJuCRzZ0s5IMF44r+e8oAdL0aMKFKNSct/ZKF0Ux3YCKg5TSjcjiZ7Hm5wNLTszI15HYnnizd3xl76EaiHhqGW6iDW6Rk6ZcbfGpNOASQhYcutMyNnhW5ZHesUaD93OK+arBSVcU9wo+l0A+xDwpuR1i+68354/PlG9y+WOw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=agSKEu9oOeYaMl0F1clscGJD7DsQDzFFARLV4HFmfe1QCzol1GaOGIu9hGcZCmSxv+LM/vVriboRzCinn8g0HpbAeB5hFdV5+f3DCtjPVdFd4T9pPE0FTeI+5HFK7jDBQIalFLG7NRrMHcoyAwB0BCbdnn5TKhzLmm7ivnIqmQA=
Received: by 10.90.92.7 with SMTP id p7mr7956781agb.1173906447558;
        Wed, 14 Mar 2007 14:07:27 -0700 (PDT)
Received: by 10.90.52.17 with HTTP; Wed, 14 Mar 2007 14:07:27 -0700 (PDT)
In-Reply-To: <17912.16608.852664.321837@lisa.zopyra.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42229>

On 3/15/07, Bill Lear <rael@zopyra.com> wrote:
> This fails, and I was wondering if anyone has any experience using
> port-forwarding and the git protocol, or if it is not presently
> possible.

We do it all the time. We have an internal server for git hosting, and
to use git+ssh you have to be inside the firewall. If you are outside,
you have to run through several SSH hops to get through the firewall.
We automate this using ssh-agent and keys forwarding.

To get ssh to work for you transparently, what you need to do is to
setup a special Host entry for your git server. For example, I have a

Host gitproxied.yourdomain
    ProxyCommand ssh firewallhost "perl -MSocket -e
'\$h=shift;socket(X,PF_INET,SOCK_STREAM,getprotobyname(\"tcp\"));connect(X,sockaddr_in(22,inet_aton(\$h)));\$x=fileno(X);vec(\$r,\$x,1)=1;vec(\$r,0,1)=1;\$|=1;\$0=\"connect
to \$h\";while(1){1 until
select(\$ro=\$r,undef,\$eo=\$r,undef);if(vec(\$ro,\$x,1)){recv(X,\$buf,2000,0);print
\$buf;}elsif(vec(\$ro,0,1)){sysread(STDIN,\$buf,2000)or
last;send(X,\$buf,0);}elsif(vec(\$eo,0,1)||vec(\$eo,\$x,1)){last}}'
git.yourdomain"

as I have several hops to go through, "firewallhost" has another Host
entry, describing how to get to it.

With this, when I'm outside the lan I can ssh into the "git" host by
invoking "ssh gitproxied.yourdomain", sftp and scp work too. So I
often have an "extra" remote called originproxied or similar.

cheers,


martin
