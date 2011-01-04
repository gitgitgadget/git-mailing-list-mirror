From: John Griessen <john@ecosensory.com>
Subject: Re: git-daemon serving repos with repo.git/git-daemon-export-ok
Date: Mon, 03 Jan 2011 19:58:47 -0600
Message-ID: <4D227ED7.9010407@ecosensory.com>
References: <S1751603Ab1ACU6e/20110103205834Z+1762@vger.kernel.org> <4D224475.1090805@ecosensory.com> <20110103231153.GA10733@burratino> <4D225DFA.50805@ecosensory.com> <20110103235501.GA32262@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 04 02:58:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PZwAq-0005St-GG
	for gcvg-git-2@lo.gmane.org; Tue, 04 Jan 2011 02:58:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206Ab1ADB6u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jan 2011 20:58:50 -0500
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.123]:33357 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750864Ab1ADB6t (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jan 2011 20:58:49 -0500
X-Authority-Analysis: v=1.1 cv=UQuFHoD2CPQ248x8AXEbKhr4z9AaDqApxmEl3BhfZ64= c=1 sm=0 a=OYK4GqB-rtkA:10 a=8nJEP1OIZ-IA:10 a=hpnIzNeuzKcqG6phuHbX0Q==:17 a=Jxrh3zc-AAAA:8 a=xhpjWSzXXrE8cmoEucAA:9 a=Ws1BWwPw6skQEYHiwhwA:7 a=dAHS5Q6Q-wg3_ZQ__EPDQJdmZLkA:4 a=wPNLvfGTeEIA:10 a=hHTGviNcZH0A:10 a=qgePg5ELsMO--DUa:21 a=yre-dmMbczF1dCUi:21 a=hpnIzNeuzKcqG6phuHbX0Q==:117
X-Cloudmark-Score: 0
X-Originating-IP: 66.68.104.159
Received: from [66.68.104.159] ([66.68.104.159:38983] helo=[192.168.15.39])
	by hrndva-oedge02.mail.rr.com (envelope-from <john@ecosensory.com>)
	(ecelerity 2.2.3.46 r()) with ESMTP
	id 19/78-00963-7DE722D4; Tue, 04 Jan 2011 01:58:48 +0000
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.13) Gecko/20101207 Lightning/1.0b2 Thunderbird/3.1.7
In-Reply-To: <20110103235501.GA32262@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164468>

On 01/03/2011 05:55 PM, Jonathan Nieder wrote:

>> I can push to these repos with gitosis, and the permissions are:
>>
>> vking@mail:/srv/gitosis/repositories$ ll
>> total 16
>> drwxr-xr-x 7 gitosis gitosis 4096 Dec 30 12:32 extrudator.data.git
>
> So the gitdaemon user (used by git-daemon-run) wouldn't be able to
> access them.

It would be able, since I used
sudo strace -o strace.out /usr/lib/git-core/git-daemon --verbose --strict-paths --user=git --group=gitosis /srv/gitosis/repositories

git-daemon was asked to run as --user=git --group=gitosis, so it had read permissions and
there was no user git-daemon anymore -- removed it from /etc/passwd.

>
>> vking@mail:/etc/sv$ cat strace.out
>> execve("/usr/lib/git-core/git-daemon",
>> ["/usr/lib/git-core/git-daemon", "--verbose", "--strict-paths",
>> "--user=git", "--group=gitosis", "/srv/gitosis/repositories"], [/*
>> 10 vars */]) = 0
>
> In this case simple --verbose output would probably be more useful.
> (That's what cat-ing /var/log/git-daemon/current would have given
> if git-daemon-run were still installed.)

I tried this

sudo /usr/lib/git-core/git-daemon --verbose --strict-paths --user=git --group=gitosis /srv/gitosis/repositories  &>git-daemon-err.log

vking@mail:~$ cat git-daemon-err.log

and git-daemon-err.log was empty.  Not the same as the /etc/sv/run script.  Should I reinstall
debian's git-daemon-run to do some tests?

>
> Thanks for the strace.  I should have mentioned that strace -f can
> help by following child processes, though that doesn't seem to be
> an issue here.  It looks like another git-daemon process is running at
> the same time?  (One can check with "netstat -t -a".)

Nope, not as far as I can see.  What suggests that?

vking@mail:/etc/sv$ netstat -t -a
Active Internet connections (servers and established)
Proto Recv-Q Send-Q Local Address           Foreign Address         State
tcp        0      0 *:discard               *:*                     LISTEN
tcp        0      0 *:git                   *:*                     LISTEN
tcp        0      0 localhost:mysql         *:*                     LISTEN
tcp        0      0 *:daytime               *:*                     LISTEN
tcp        0      0 localhost:sunrpc        *:*                     LISTEN
tcp        0      0 *:www                   *:*                     LISTEN
tcp        0      0 localhost:690           *:*                     LISTEN
tcp        0      0 cottagematic.com:domain *:*                     LISTEN
tcp        0      0 mail.cibolo.us:domain   *:*                     LISTEN
tcp        0      0 localhost:domain        *:*                     LISTEN
tcp        0      0 *:ssh                   *:*                     LISTEN
tcp        0      0 *:telnet                *:*                     LISTEN
tcp        0      0 localhost:postgresql    *:*                     LISTEN
tcp        0      0 *:smtp                  *:*                     LISTEN
tcp        0      0 *:time                  *:*                     LISTEN
tcp        0      0 *:ldap                  *:*                     LISTEN
tcp        0      0 mail.cibolo.us:ssh      cpe-66-68-104-159:47248 ESTABLISHED
tcp        0    224 mail.cibolo.us:ssh      cpe-66-68-104-159:47247 ESTABLISHED
tcp6       0      0 *:pop3                  *:*                     LISTEN
tcp6       0      0 *:imap2                 *:*                     LISTEN
tcp6       0      0 *:ssh                   *:*                     LISTEN
tcp6       0      0 *:imaps                 *:*                     LISTEN
tcp6       0      0 *:pop3s                 *:*                     LISTEN
tcp6       0      0 *:ldap                  *:*                     LISTEN
tcp6       0      0 mail.cibolo.us:imaps    cpe-66-68-104-159:58203 ESTABLISHED
tcp6       0      0 mail.cibolo.us:imaps    cpe-66-68-104-159:58226 ESTABLISHED
tcp6       0      0 mail.cibolo.us:imaps    cpe-66-68-104-159:48747 ESTABLISHED
tcp6       0      0 mail.cibolo.us:imaps    cpe-66-68-104-159:58175 ESTABLISHED
tcp6       0      0 mail.cibolo.us:imaps    cpe-66-68-104-159:58174 ESTABLISHED
tcp6       0      0 mail.cibolo.us:imaps    cpe-66-68-104-159:48951 ESTABLISHED
tcp6       0      0 mail.cibolo.us:imaps    cpe-66-68-104-159:52013 ESTABLISHED
tcp6       0      0 mail.cibolo.us:imaps    cpe-66-68-104-159:52012 ESTABLISHED
tcp6       0      0 mail.cibolo.us:imaps    cpe-66-68-104-159:52015 ESTABLISHED
tcp6       0      0 mail.cibolo.us:imaps    cpe-66-68-104-159:52014 ESTABLISHED
tcp6       0      0 mail.cibolo.us:imaps    cpe-66-68-104-159:47076 ESTABLISHED
tcp6       0      0 mail.cibolo.us:imaps    cpe-66-68-104-159:47079 ESTABLISHED
tcp6       0      0 mail.cibolo.us:imaps    cpe-66-68-104-159:47078 ESTABLISHED


John Griessen
