From: Kevin Ballard <kevin@sb.org>
Subject: Re: git filter-branch should run git gc --auto
Date: Tue, 22 Jan 2008 21:58:09 -0500
Message-ID: <60D6C8F5-EF88-48F0-92CA-8E49838C0CB9@sb.org>
References: <20080119123557.GA30778@diana.vm.bytemark.co.uk> <20080119223249.8227.31460.stgit@yoghurt> <1200783050.5724.196.camel@brick> <20080120033737.GA7767@soma> <20080120093436.GA10924@diana.vm.bytemark.co.uk> <7vlk6k8fyp.fsf@gitster.siamese.dyndns.org> <20080121224818.GA8872@untitled> <7vr6gawvkt.fsf@gitster.siamese.dyndns.org> <20080122003911.GA16453@hand.yhbt.net> <7vtzl6vd7v.fsf@gitster.siamese.dyndns.org> <BE604744-0D26-4A39-85CE-B5C0C8C00F9E@sb.org> <7v1w89qmw3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: multipart/signed; boundary=Apple-Mail-58--588409945; micalg=sha1; protocol="application/pkcs7-signature"
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 23 03:58:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHVp5-0005G2-0U
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 03:58:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751761AbYAWC6N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2008 21:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752507AbYAWC6N
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jan 2008 21:58:13 -0500
Received: from sd-green-bigip-177.dreamhost.com ([208.97.132.177]:44575 "EHLO
	randymail-a6.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751602AbYAWC6M (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Jan 2008 21:58:12 -0500
Received: from KBALLARD.RES.WPI.NET (KBALLARD.RES.WPI.NET [130.215.239.91])
	by randymail-a6.g.dreamhost.com (Postfix) with ESMTP id 98540175E70;
	Tue, 22 Jan 2008 18:58:10 -0800 (PST)
In-Reply-To: <7v1w89qmw3.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71501>


--Apple-Mail-58--588409945
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit

On Jan 22, 2008, at 9:46 PM, Junio C Hamano wrote:

> Kevin Ballard <kevin@sb.org> writes:
>
>> I just glanced at git-filter-branch.sh (and I must say I was
>> incredibly surprised to find out it was a shell script) and it seems
>> it never runs git-gc or git-repack. Doesn't that end up with the same
>> problems as git-svn sans git-repack when filtering a large number of
>> commits? I was just thinking, if I were to git-filter-branch on my
>> massive repo (in fact, the same repo that started this thread, with
>> over 33000 commits in the upstream svn repo), even if I just do
>> something as simple as change the commit msg wont I end up with
>> thousands of unreachable objects? I shudder to think how many
>> unreachable objects I would have if I pruned the entire dports
>> directory off of the tree.
>>
>> Am I missing something, or does git-filter-branch really not do any
>> garbage collection? I tried reading the source, but complex bash
>> scripts are almost as bad as perl in terms of readability.
>
> Theoretically yes, and it largely depends on what you do, but
> filter-branch goes over the objects that already exists in your
> repository, and hopefully you won't be rewriting majority of
> them.
>
> So the impact of not repacking is probably much less painful in
> practice.
>
> But again as I said, it largely depends on what you do in your
> filter.  If you are upcasing (or convert to NFD ;-)) the
> contents of all of your blob objects, you would certainly want
> to repack every once in a while.


I'm actually considering what the cost would be of switching macports  
to git (not that it will ever happen - too many anonymous people pull  
from svn trunk). Right now the svn trunk contains a subfolder for the  
source code and another subfolder for all ~4400+ Portfiles. In such a  
theoretical move, I'd want to split that up, probably into two  
unrelated branches. Doing so would mean running git-filter-branch over  
a linear commit history that's 31580 objects long, with a tree filter  
to prune the dports directory away and a msg filter to remove the svn- 
id stuff that git-svn left behind. This means that every single commit  
objects would be changed, as well as the root tree object for every  
single commit. That would be about 63160 objects. I'd also have to  
figure out some way to remove the commit objects entirely that only  
reference the dports directory. Then I'd have to do it again with the  
opposite tree filter (to prune everything but the dports directory and  
move the contents of the dports directory up one level) and same msg  
filter. Granted, if I do the first action in a branch, that leaves no  
unreachable objects (since the originals are still referenced), but  
the second operation definitely would leave unreachable objects, and  
were I to clone the repository instead and do the operations in the  
different repos (which is perfectly legitimate - otherwise I'd have to  
clone it after everything else and then delete branches) then both  
actions would leave thousands of objects unreachable.

I'd suggest a patch to run git gc --auto, but it looks like you just  
did in a subsequent email. As for your comments about the reflogs,  
can't I disable recording those, at least temporarily? I'd rather  
clean up after myself as I work rather than balloon the repository and  
collapse it in a single operation at the end.

-Kevin Ballard

-- 
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com



--Apple-Mail-58--588409945
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIGMjCCAusw
ggJUoAMCAQICEDsG8BKvlrEW0HUBIxWIgjUwDQYJKoZIhvcNAQEFBQAwYjELMAkGA1UEBhMCWkEx
JTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQ
ZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMB4XDTA3MDQyMzIxMjM0OVoXDTA4MDQyMjIxMjM0
OVowVzEQMA4GA1UEBBMHQmFsbGFyZDEOMAwGA1UEKhMFS2V2aW4xFjAUBgNVBAMTDUtldmluIEJh
bGxhcmQxGzAZBgkqhkiG9w0BCQEWDGtldmluQHNiLm9yZzCCASIwDQYJKoZIhvcNAQEBBQADggEP
ADCCAQoCggEBAN/koURrN2ndrAiuAuHHrdFz+hLGQ7ZsXloGnObjALGOFY3Kmk2FCwAJPIha5GfM
YFmZIoqxs+DbOWOn6KZ9hcQ5wf4EOgokayrEs3G72T+G8ZE4aXrw0CWJzKLjaIQeDZNZoHA44jlZ
dG70wtZske898IoPz6YHpkcXiulllATfd8Pa7EgjPri5hKFiRXKI52OsOQTX6cNMMZJUIm8DvfQ5
jmDyAtywNZGSGeUAMbWnpuLq7H18zpye2Q1hr+p4kucazMb+i7OHXPvX7yx2jMjhN5jw/gYkuzQQ
JExp1fJyAZQ/av/ZgaxWchhhi4ziFXIlX3B09DTlOQlF53P3fi0CAwEAAaMpMCcwFwYDVR0RBBAw
DoEMa2V2aW5Ac2Iub3JnMAwGA1UdEwEB/wQCMAAwDQYJKoZIhvcNAQEFBQADgYEAw/qc6zq+0Qy2
XaodDlt2L6Vq1DzaVWjV152BFjidmsyhyCkCuyYdAcDp17opIfrNCBbOX5DdY6cpFpnSCxCZeIEB
PDc3TaaFPtzr8qrpcNDohRSdt+qFLUeMHzlidAiAjvjI3tPKv3JLTakWdQR/XPHsg4mWoaVQU2hM
HOQBw8EwggM/MIICqKADAgECAgENMA0GCSqGSIb3DQEBBQUAMIHRMQswCQYDVQQGEwJaQTEVMBMG
A1UECBMMV2VzdGVybiBDYXBlMRIwEAYDVQQHEwlDYXBlIFRvd24xGjAYBgNVBAoTEVRoYXd0ZSBD
b25zdWx0aW5nMSgwJgYDVQQLEx9DZXJ0aWZpY2F0aW9uIFNlcnZpY2VzIERpdmlzaW9uMSQwIgYD
VQQDExtUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgQ0ExKzApBgkqhkiG9w0BCQEWHHBlcnNvbmFs
LWZyZWVtYWlsQHRoYXd0ZS5jb20wHhcNMDMwNzE3MDAwMDAwWhcNMTMwNzE2MjM1OTU5WjBiMQsw
CQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UE
AxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0EwgZ8wDQYJKoZIhvcNAQEBBQAD
gY0AMIGJAoGBAMSmPFVzVftOucqZWh5owHUEcJ3f6f+jHuy9zfVb8hp2vX8MOmHyv1HOAdTlUAow
1wJjWiyJFXCO3cnwK4Vaqj9xVsuvPAsH5/EfkTYkKhPPK9Xzgnc9A74r/rsYPge/QIACZNenpruf
ZdHFKlSFD0gEf6e20TxhBEAeZBlyYLf7AgMBAAGjgZQwgZEwEgYDVR0TAQH/BAgwBgEB/wIBADBD
BgNVHR8EPDA6MDigNqA0hjJodHRwOi8vY3JsLnRoYXd0ZS5jb20vVGhhd3RlUGVyc29uYWxGcmVl
bWFpbENBLmNybDALBgNVHQ8EBAMCAQYwKQYDVR0RBCIwIKQeMBwxGjAYBgNVBAMTEVByaXZhdGVM
YWJlbDItMTM4MA0GCSqGSIb3DQEBBQUAA4GBAEiM0VCD6gsuzA2jZqxnD3+vrL7CF6FDlpSdf0wh
uPg2H6otnzYvwPQcUCCTcDz9reFhYsPZOhl+hLGZGwDFGguCdJ4lUJRix9sncVcljd2pnDmOjCBP
ZV+V2vf3h9bGCE6u9uo05RAaWzVNd+NWIXiC3CEZNd4ksdMdRv9dX2VPMYIDEDCCAwwCAQEwdjBi
MQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoG
A1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0ECEDsG8BKvlrEW0HUBIxWI
gjUwCQYFKw4DAhoFAKCCAW8wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUx
DxcNMDgwMTIzMDI1ODA5WjAjBgkqhkiG9w0BCQQxFgQUAyazkDw9VPvs0Zpx8GNHNy8NwtswgYUG
CSsGAQQBgjcQBDF4MHYwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5n
IChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENB
AhA7BvASr5axFtB1ASMViII1MIGHBgsqhkiG9w0BCRACCzF4oHYwYjELMAkGA1UEBhMCWkExJTAj
BgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJz
b25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAhA7BvASr5axFtB1ASMViII1MA0GCSqGSIb3DQEBAQUA
BIIBAEtc3dPtPUUVhKF1VckrWWbui4iJWivdFInlwBl7kSi7RTCnOLuSNepJ/8KOMpb2HhiL70r2
Sg59eaM0+wjYmxpNKLKciObrHYweIj74GzifgVLt4u9Cnjo+upmKWqYnIe0J8BKz6v+ICPsxjEqa
tFStRQv5cJStV/OS08CB75r3yZ7teYQWlQsc+qbuCkIfkgp4QIPSPtcEtYAqatFavKep2wdsdSyC
Jlhnuv7BBXoEozIvEKZyLwG0/roO8JomEtJPyHH+RNQeYubD/qwF3f3GRzq3XViajvLjJnpmFcwE
nq9eygkZ/Zz4ka1Bk70s9/FhXYHHyoMJhCNFr3Z7uhQAAAAAAAA=

--Apple-Mail-58--588409945--
